import AVFoundation

/// An enumeration describing barcode types which are supported by the `BarcodeScannerView`.
public enum BarcodeType {
    /// Describes the *UPC-E* code format.
    case upce
    /// Describes the *Code 39* code format.
    case code39
    /// Describes the *Code 39 mod 43* code format.
    case code39Mod43
    /// Describes the *EAN-13 (including UPC-A)* code format.
    case ean13
    /// Describes the *EAN-8* code format.
    case ean8
    /// Describes the *Code 93* code format.
    case code93
    /// Describes the *Code 128* code format.
    case code128
    /// Describes the *PDF417* code format.
    case pdf417
    /// Describes the *QR* code format.
    case qr
    /// Describes the *Aztec* code format.
    case aztec
    /// Describes the *Interleaved 2 of 5* code format.
    case interleaved2of5
    /// Describes the *ITF14* code format.
    case itf14
    /// Describes the *DataMatrix* code format.
    case dataMatrix
}

extension BarcodeType {
    internal var rawValue: AVMetadataObject.ObjectType {
        switch self {
            case .upce:
                return .upce

            case .code39:
                return .code39

            case .code39Mod43:
                return .code39Mod43

            case .ean13:
                return .ean13

            case .ean8:
                return .ean8

            case .code93:
                return .code93

            case .code128:
                return .code128

            case .pdf417:
                return .pdf417

            case .qr:
                return .qr

            case .aztec:
                return .aztec

            case .interleaved2of5:
                return .interleaved2of5

            case .itf14:
                return .itf14

            case .dataMatrix:
                return .dataMatrix
        }
    }

    internal init?(rawValue: AVMetadataObject.ObjectType) {
        switch rawValue {
        case .upce:
            self = .upce

        case .code39:
            self = .code39

        case .code39Mod43:
            self = .code39Mod43

        case .ean13:
            self = .ean13

        case .ean8:
            self = .ean8

        case .code93:
            self = .code93

        case .code128:
            self = .code128

        case .pdf417:
            self = .pdf417

        case .qr:
            self = .qr

        case .aztec:
            self = .aztec

        case .interleaved2of5:
            self = .interleaved2of5

        case .itf14:
            self = .itf14

        case .dataMatrix:
            self = .dataMatrix

        default:
            return nil
        }
    }
}
