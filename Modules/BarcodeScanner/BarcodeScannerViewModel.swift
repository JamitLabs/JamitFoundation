import JamitFoundation
import UIKit

/// The state view model for `BarcodeScannerView`.
public struct BarcodeScannerViewModel: ViewModelProtocol {
    /// The callback type for a successful barcode scan result.
    public typealias SuccessCallback = ([Barcode]) -> Void
    /// The callback type for an error in the barcode scan process.
    public typealias ErrorCallback = (BarcodeScannerError) -> Void

    /// The barcode types which should be captured by the `BarcodeScannerView`.
    public let barcodeTypes: [BarcodeType]
    /// The callback for a successful barcode scan result.
    public let onSuccess: SuccessCallback
    /// The callback for an error occuring in the scan process.
    public let onError: ErrorCallback

    /// The default initializer of `BarcodeScannerViewModel`.
    ///
    /// - Parameters:
    ///   - barcodeTypes: The barcode types which should be captured by the `BarcodeScannerView`.
    ///   - onSuccess: The callback for a successful barcode scan result.
    ///   - onError: The callback for an error occuring in the scan process.
    public init(
        barcodeTypes: [BarcodeType] = Self.default.barcodeTypes,
        onSuccess: @escaping SuccessCallback = Self.default.onSuccess,
        onError: @escaping ErrorCallback = Self.default.onError
    ) {
        self.barcodeTypes = barcodeTypes
        self.onSuccess = onSuccess
        self.onError = onError
    }
}

extension BarcodeScannerViewModel {
    /// The default state of `PageViewModel`.
    public static let `default`: Self = .init(
        barcodeTypes: [],
        onSuccess: { _ in },
        onError: { _ in }
    )
}
