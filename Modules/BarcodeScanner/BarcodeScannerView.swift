import AVFoundation
import JamitFoundation
import UIKit

public final class BarcodeScannerView: StatefulView<BarcodeScannerViewModel> {
    private lazy var captureSession: AVCaptureSession = .init()
    private lazy var captureDevice: AVCaptureDevice? = .default(for: .video)
    private var captureSessionQueue: DispatchQueue = .init(
        label: "com.jamitlabs.JamitFoundation.BarcodeScannerView.CaptureSessionQueue",
        attributes: [],
        target: nil
    )

    private var captureDeviceInput: AVCaptureDeviceInput?
    private lazy var captureMetadataOutput: AVCaptureMetadataOutput = .init()
    private lazy var captureVideoPreviewLayer: AVCaptureVideoPreviewLayer = .init(session: captureSession)

    private var isCaptureSessionConfigured: Bool = false
    private var isCaptureSessionRunning: Bool = false

    private var isScanningEnabled: Bool = false {
        didSet { didChangeState() }
    }

    private(set) var isScanning: Bool = false {
        didSet { didChangeState() }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        captureVideoPreviewLayer.frame = bounds
        captureVideoPreviewLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(captureVideoPreviewLayer)

        captureSessionQueue.suspend()
        captureSessionQueue.async { [weak self] in
            guard let self = self else { return }

            self.captureSession.beginConfiguration()
            defer { self.captureSession.commitConfiguration() }

            if self.captureSession.canSetSessionPreset(.high) {
                self.captureSession.sessionPreset = .high
            }

            guard let captureDevice = self.captureDevice else {
                return DispatchQueue.main.async { [weak self] in
                    self?.model.onError(.videoCapturingDeviceNotAvailable)
                }
            }

            guard let captureDeviceInput = try? AVCaptureDeviceInput(device: captureDevice) else {
                return DispatchQueue.main.async { [weak self] in
                    self?.model.onError(.videoCapturingConfigurationFailed)
                }
            }

            guard self.captureSession.canAddInput(captureDeviceInput) else { return }

            self.captureSession.addInput(captureDeviceInput)
            self.captureDeviceInput = captureDeviceInput

            guard self.captureSession.canAddOutput(self.captureMetadataOutput) else {
                return DispatchQueue.main.async { [weak self] in
                    self?.model.onError(.videoCapturingConfigurationFailed)
                }
            }

            self.captureSession.addOutput(self.captureMetadataOutput)
            self.captureMetadataOutput.metadataObjectTypes = self.model.barcodeTypes.map { $0.rawValue }
            self.captureMetadataOutput.setMetadataObjectsDelegate(self, queue: .main)
            self.isCaptureSessionConfigured = true

            DispatchQueue.main.async { [weak self] in
                self?.setVideoOrientation(to: UIApplication.shared.statusBarOrientation)
                self?.didChangeState()
            }
        }
    }

    public override func didChangeModel() {
        super.didChangeModel()

        captureSessionQueue.async { [weak self] in
            guard let self = self, self.isCaptureSessionConfigured else { return }

            self.captureSession.beginConfiguration()
            defer { self.captureSession.commitConfiguration() }

            self.captureMetadataOutput.metadataObjectTypes = self.model.barcodeTypes.map { $0.rawValue }
        }
    }

    public override func willMove(toSuperview newSuperview: UIView?) {
        switch (superview, newSuperview) {
        case (.none, .some):
            isScanningEnabled = true

        case (.some, .none):
            isScanningEnabled = false

        default:
            break
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        captureVideoPreviewLayer.frame = bounds
    }

    private func didChangeState() {
        if isScanning, isScanningEnabled, !isCaptureSessionRunning {
            self.captureSessionQueue.async { [weak self] in
                guard let self = self else { return }

                self.addObservers()
                self.captureSession.startRunning()
                self.isCaptureSessionRunning = self.captureSession.isRunning
            }
        }

        if (!isScanning || !isScanningEnabled), isCaptureSessionRunning {
            self.captureSessionQueue.async { [weak self] in
                guard let self = self else { return }

                self.captureSession.stopRunning()
                self.isCaptureSessionRunning = self.captureSession.isRunning
                self.removeObservers()
            }
        }
    }

    // MARK: - Capture Session Management
    public func startScanning() {
        guard !isScanning else { return }

        isScanning = true

        requestVideoCapturingAuthorization { [weak self] accessGranted in
            if accessGranted {
                self?.captureSessionQueue.resume()
            } else {
                self?.model.onError(.videoCapturingNotAuthorized)
            }
        }
    }

    public func stopScanning() {
        guard isScanning else { return }

        isScanning = false
    }

    private func requestVideoCapturingAuthorization(_ response: @escaping (Bool) -> Void) {
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if authorizationStatus == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { accessGranted in
                DispatchQueue.main.async { response(accessGranted) }
            }
        } else {
            response(authorizationStatus == .authorized)
        }
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(captureDeviceSubjectAreaDidChange(_:)),
            name: Notification.Name.AVCaptureDeviceSubjectAreaDidChange,
            object: captureDeviceInput?.device
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(captureSessionRuntimeError(_:)),
            name: .AVCaptureSessionRuntimeError,
            object: captureSession
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(statusBarOrientationDidChange),
            name: UIApplication.didChangeStatusBarOrientationNotification,
            object: nil
        )
    }

    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }

    private func setVideoOrientation(to interfaceOrientation: UIInterfaceOrientation) {
        guard let videoPreviewLayerConnection = captureVideoPreviewLayer.connection else { return }

        switch interfaceOrientation {
        case .portrait:
            videoPreviewLayerConnection.videoOrientation = .portrait

        case .portraitUpsideDown:
            videoPreviewLayerConnection.videoOrientation = .portraitUpsideDown

        case .landscapeLeft:
            videoPreviewLayerConnection.videoOrientation = .landscapeLeft

        case .landscapeRight:
            videoPreviewLayerConnection.videoOrientation = .landscapeRight

        default:
            videoPreviewLayerConnection.videoOrientation = .portrait
        }
    }

    @objc
    private func statusBarOrientationDidChange(_ notification: NSNotification) {
        guard let rawInterfaceOrientation = notification.userInfo?[UIApplication.statusBarOrientationUserInfoKey] as? Int else { return }
        guard let interfaceOrientation = UIInterfaceOrientation(rawValue: rawInterfaceOrientation) else { return }

        setVideoOrientation(to: interfaceOrientation)
    }

    @objc
    private func captureDeviceSubjectAreaDidChange(_ notification: NSNotification) {
        captureSessionQueue.async { [weak self] in
            guard let self = self, let device = self.captureDeviceInput?.device else { return }

            do {
                try device.lockForConfiguration()
                defer { device.unlockForConfiguration() }

                if device.isFocusPointOfInterestSupported, device.isFocusModeSupported(.continuousAutoFocus) {
                    device.focusPointOfInterest = CGPoint(x: 0.5, y: 0.5)
                    device.focusMode = .continuousAutoFocus
                }

                if device.isExposurePointOfInterestSupported && device.isExposureModeSupported(.continuousAutoExposure) {
                    device.exposurePointOfInterest = CGPoint(x: 0.5, y: 0.5)
                    device.exposureMode = .continuousAutoExposure
                }

                device.isSubjectAreaChangeMonitoringEnabled = false
            } catch {
                DispatchQueue.main.async {
                    self.model.onError(.deviceLockingForConfigurationFailed)
                }
            }
        }
    }

    @objc
    private func captureSessionRuntimeError(_ notification: NSNotification) {
        guard let errorValue = notification.userInfo?[AVCaptureSessionErrorKey] as? NSError else { return }

        let error = AVError(_nsError: errorValue)
        if error.code == .mediaServicesWereReset {
            captureSessionQueue.async { [weak self] in
                guard let self = self, self.isCaptureSessionRunning else { return }

                self.captureSession.startRunning()
                self.isCaptureSessionRunning = self.captureSession.isRunning
            }
        } else {
            model.onError(.runtimeError(error))
        }
    }
}

extension BarcodeScannerView: AVCaptureMetadataOutputObjectsDelegate {
    public func metadataOutput(
        _ output: AVCaptureMetadataOutput,
        didOutput metadataObjects: [AVMetadataObject],
        from connection: AVCaptureConnection
    ) {
        let barcodes = metadataObjects.compactMap { metadataObject -> Barcode? in
            guard let machineReadableCodeObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return nil }

            return Barcode(
                type: BarcodeType(rawValue: machineReadableCodeObject.type),
                body: machineReadableCodeObject.stringValue ?? ""
            )
        }

        guard barcodes.count > 0 else { return }

        model.onScan(barcodes)
    }
}
