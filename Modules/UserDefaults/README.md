#  UserDefaults

The user defaults module provides a property wrapper to access data in the device user defaults storage.

Example:

```swift
struct MyDataRepository {
    @UserDefault(key: "<#value identifier#>", defaultValue: true)
    var myPersistentProperty: Bool
}
```
