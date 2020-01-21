import JamitFoundation
import UIKit

public struct BarcodeScannerViewModel: ViewModelProtocol {
    public typealias ScanCallback = ([Barcode]) -> Void
    public typealias ErrorCallback = (BarcodeScannerError) -> Void

    public let barcodeTypes: [BarcodeType]
    public let onScan: ScanCallback
    public let onError: ErrorCallback

    public init(
        barcodeTypes: [BarcodeType] = Self.default.barcodeTypes,
        onScan: @escaping ScanCallback = Self.default.onScan,
        onError: @escaping ErrorCallback = Self.default.onError
    ) {
        self.barcodeTypes = barcodeTypes
        self.onScan = onScan
        self.onError = onError
    }
}

extension BarcodeScannerViewModel {
    public static let `default`: Self = .init(
        barcodeTypes: [],
        onScan: { _ in },
        onError: { _ in }
    )
}
