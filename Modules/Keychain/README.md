#  Keychain

The keychain module provides an easy to use API agnostic to the device keychain and the iOS `Security` framework.

```swift
struct MyDataRepository {
    @Secured(key: "<#keychain value identifier#>")
    var topSecretSecuredValue: Bool
}
```
