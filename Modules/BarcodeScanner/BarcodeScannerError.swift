import Foundation

public enum BarcodeScannerError: Error {
    case videoCapturingNotAuthorized
    case videoCapturingConfigurationFailed
    case videoCapturingDeviceNotAvailable
    case deviceLockingForConfigurationFailed
    case runtimeError(Error)
}
