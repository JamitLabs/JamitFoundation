import Foundation

/// An error type describing errors occuring in the `BarcodeScannerView` at runtime.
public enum BarcodeScannerError: Error {
    /// An error that occurs when the application is not authorized to capture video.
    case videoCapturingNotAuthorized
    /// An error that occurs when the configuration of the capturing session fails.
    case videoCapturingConfigurationFailed
    /// An error that occurs when there is no device available for video capturing.
    case videoCapturingDeviceNotAvailable
    /// An error that occurs when the media device cannot be locked for configuration.
    case deviceLockingForConfigurationFailed
    /// An error that wraps underlying errors which are occuring at runtime.
    case runtimeError(Error)
}
