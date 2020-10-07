import AVFoundation
import JamitFoundation
import UIKit

/// A stateful view which presents a video capturing preview and scans the content of it for barcodes.
///
/// Example:
/// ```swift
/// // Instantiation of the barcode scanner view.
/// let barcodeScannerView = BarcodeScannerView.instantiate()
///
/// // Configuration of the expected barcode types and the callbacks.
/// barcodeScannerView.model = .init(
///     barcodeTypes: [.qr],
///     onScan: { barcodes in
///         print(barcodes)
///     },
///     onError: { error in
///         print(error)
///     }
/// )
///
/// // Starting the scan process.
/// scannerView.startScanning()
///
/// // Stopping the scan process.
/// scannerView.stopScanning()
/// ```
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

    private var isDeinited: Bool = false

    private var isScanningEnabled: Bool = false {
        didSet { didChangeState() }
    }

    /// A flag describing the scan process state.
    ///
    /// If `isScanning` is true then the scan process is running.
    ///
    /// - NOTE: This value is not always returning the current state of the capture session,
    ///         it always reflects the last invocation state of the `startScanning` and `stopScanning` methods.
    ///         When there is a runtime issue starting the scan process then this value can still be `true`
    ///         even if the capturing session is not running at the moment.
    public private(set) var isScanning: Bool = false {
        didSet { didChangeState() }
    }

    deinit {
        // Resuming the capture session queue before release is mandatory to avoid crashes
        isDeinited = true
        captureSessionQueue.resume()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        captureVideoPreviewLayer.frame = bounds
        captureVideoPreviewLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(captureVideoPreviewLayer)

        captureSessionQueue.suspend()
        captureSessionQueue.async { [weak self] in
            guard let self = self, !self.isDeinited else { return }

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

            guard self.captureSession.canAddInput(captureDeviceInput) else {
                return DispatchQueue.main.async { [weak self] in
                    self?.model.onError(.videoCapturingConfigurationFailed)
                }
            }

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
            guard let self = self, self.isCaptureSessionConfigured, !self.isDeinited else { return }

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
                guard let self = self, !self.isDeinited else { return }

                self.addObservers()
                self.captureSession.startRunning()
                self.isCaptureSessionRunning = self.captureSession.isRunning
            }
        }

        if (!isScanning || !isScanningEnabled), isCaptureSessionRunning {
            self.captureSessionQueue.async { [weak self] in
                guard let self = self, !self.isDeinited else { return }

                self.captureSession.stopRunning()
                self.isCaptureSessionRunning = self.captureSession.isRunning
                self.removeObservers()
            }
        }
    }

    /// Starts the scan process for the given `barcodeTypes` in the `model`.
    public func startScanning() {
        guard !isScanning else { return }

        isScanning = true

        requestVideoCapturingAuthorization { [weak self] accessGranted in
            guard let self = self else { return }

            if !accessGranted {
                self.model.onError(.videoCapturingNotAuthorized)
            } else if !self.isCaptureSessionConfigured {
                self.captureSessionQueue.resume()
            }
        }
    }

    /// Stops the scann process for the given `barcodeTypes` in the `model`.
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
            guard let self = self, let device = self.captureDeviceInput?.device, !self.isDeinited else { return }

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
                guard let self = self, self.isCaptureSessionRunning, !self.isDeinited else { return }

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
            guard let type = BarcodeType(rawValue: machineReadableCodeObject.type) else { return nil }

            return Barcode(type: type, body: machineReadableCodeObject.stringValue ?? "")
        }

        guard !barcodes.isEmpty else { return }

        model.onSuccess(barcodes)
    }
}
