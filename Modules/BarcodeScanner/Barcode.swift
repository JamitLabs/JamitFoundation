import Foundation

/// A descriptor containing informations about a bar code.
public struct Barcode {
    /// The type of the `Barcode`.
    public let type: BarcodeType
    /// The content of the `Barcode`.
    public let body: String

    internal init(type: BarcodeType, body: String) {
        self.type = type
        self.body = body
    }
}
