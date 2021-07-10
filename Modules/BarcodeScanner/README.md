#  BarcodeScanner

The barcode scanner presents a video capturing preview and scans the content of it for barcodes.

Example:
 ```swift
// Instantiation of the barcode scanner view.
let barcodeScannerView = BarcodeScannerView.instantiate()

// Configuration of the expected barcode types and the callbacks.
barcodeScannerView.model = .init(
    barcodeTypes: [.qr],
    onScan: { barcodes in
        print(barcodes)
    },
    onError: { error in
        print(error)
    }
)

// Starting the scan process.
scannerView.startScanning()

// Stopping the scan process.
scannerView.stopScanning()
```
