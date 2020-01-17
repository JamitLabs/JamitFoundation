import AVFoundation

public struct BarcodeType: RawRepresentable {
    public let rawValue: AVMetadataObject.ObjectType

    public init(rawValue: AVMetadataObject.ObjectType) {
        self.rawValue = rawValue
    }

    public static let upce: Self = .init(rawValue: .upce)
    public static let code39: Self = .init(rawValue: .code39)
    public static let code39Mod43: Self = .init(rawValue: .code39Mod43)
    public static let ean13: Self = .init(rawValue: .ean13)
    public static let ean8: Self = .init(rawValue: .ean8)
    public static let code93: Self = .init(rawValue: .code93)
    public static let code128: Self = .init(rawValue: .code128)
    public static let pdf417: Self = .init(rawValue: .pdf417)
    public static let qr: Self = .init(rawValue: .qr)
    public static let aztec: Self = .init(rawValue: .aztec)
    public static let interleaved2of5: Self = .init(rawValue: .interleaved2of5)
    public static let itf14: Self = .init(rawValue: .itf14)
    public static let dataMatrix: Self = .init(rawValue: .dataMatrix)
}
