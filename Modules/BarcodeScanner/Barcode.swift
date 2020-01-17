import Foundation

public struct Barcode {
    public let type: BarcodeType
    public let body: String

    internal init(type: BarcodeType, body: String) {
        self.type = type
        self.body = body
    }
}
