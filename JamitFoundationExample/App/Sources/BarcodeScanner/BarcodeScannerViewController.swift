//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import BarcodeScanner
import JamitFoundation
import UIKit

final class BarcodeScannerViewController: StatefulViewController<BarcodeScannerViewControllerViewModel> {
    @IBOutlet private var contentView: UIView!

    private lazy var barcodeScannerView: BarcodeScannerView = {
        let barcodeScannerView: BarcodeScannerView = .init()
        barcodeScannerView.model = .init(
        barcodeTypes: [.qr],
        onSuccess: { [weak self] barcodes in
            self?.handleBarcodes(barcodes)
        },
        onError: { [weak self] error in
            self?.handleBarcodeScannerError(error)
        })
        return barcodeScannerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "BarcodeScannerViewController"

        barcodeScannerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(barcodeScannerView)
        barcodeScannerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        barcodeScannerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        barcodeScannerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        barcodeScannerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        barcodeScannerView.startScanning()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        barcodeScannerView.stopScanning()
    }

    private func handleBarcodes(_ barcodes: [Barcode]) {
        print(barcodes)
        guard let message = barcodes.first?.body else { return }

        if let url = URL(string: message), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            barcodeScannerView.stopScanning()
            showAlertController(
                with: NSLocalizedString("BARCODE_SCANNER_VIEW_CONTROLLER.BARCODE_DETECTED.ALERT.TITLE", comment: ""),
                and: message
            )
        }
    }

    private func handleBarcodeScannerError(_ error: BarcodeScannerError) {
        barcodeScannerView.stopScanning()

        switch error {
        case .videoCapturingNotAuthorized:
            showAlertForCameraSettings()

        default:
            showAlertController(
                with: NSLocalizedString("BARCODE_SCANNER_VIEW_CONTROLLER.BARCODE_DETECTION_FAILED.ALERT.TITLE", comment: ""),
                and: error.localizedDescription
            )
        }
    }

    private func showAlertController(with title: String, and message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let startScanningAction = UIAlertAction(
            title: NSLocalizedString("BARCODE_SCANNER_VIEW_CONTROLLER.BARCODE_DETECTED.ALERT.ACTION_SCAN_FOR_OTHERS.TITLE", comment: ""),
            style: .default
        ) { [weak self] _ in
            self?.barcodeScannerView.startScanning()
        }

        let dismissAction = UIAlertAction(
            title: NSLocalizedString("BARCODE_SCANNER_VIEW_CONTROLLER.BARCODE_DETECTED.ALERT.ACTION_GO_BACK.TITLE", comment: ""),
            style: .destructive
        ) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(startScanningAction)
        alertController.addAction(dismissAction)

        present(alertController, animated: true)
        
    }

    private func showAlertForCameraSettings() {
        let alertController = UIAlertController(
            title: NSLocalizedString("BARCODE_SCANNER_VIEW_CONTROLLER.BARCODE_DETECTED.ALERT.CAMERA_PERMISSION_NEEDED.TITLE", comment: ""),
            message: NSLocalizedString("BARCODE_SCANNER_VIEW_CONTROLLER.BARCODE_DETECTED.ALERT.CAMERA_PERMISSION_NEEDED.MESSAGE", comment: ""),
            preferredStyle: .alert
        )

        let goToSettingsAction = UIAlertAction(
            title: NSLocalizedString("BARCODE_SCANNER_VIEW_CONTROLLER.BARCODE_DETECTED.ALERT.CAMERA_PERMISSION_NEEDED.ACTION.GO_TO_SETTINGS.TITLE", comment: ""),
            style: .default
        ) { [weak self] _ in
            self?.openAppSettings()
        }

        let dismissAction = UIAlertAction(
            title: NSLocalizedString("BARCODE_SCANNER_VIEW_CONTROLLER.BARCODE_DETECTED.ALERT.CAMERA_PERMISSION_NEEDED.ACTION.GO_BACK.TITLE", comment: ""),
            style: .destructive
        ) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(goToSettingsAction)
        alertController.addAction(dismissAction)

        present(alertController, animated: true)
    }

    private func openAppSettings() {
        guard
            let settingsUrl = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(settingsUrl)
        else {
            return
        }

        UIApplication.shared.open(settingsUrl)
    }
}
