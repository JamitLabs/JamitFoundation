import Foundation

///
/// `UserDefault` is a property wrapper that can be applied to any codable property to store it in the user defaults
///
/// Example:
/// ```swift
/// @UserDefault(key: "user_defaults.default.value_key", defaultValue: true)
/// var value: Bool
/// ```
@propertyWrapper
public struct UserDefault<Value> where Value: Codable {
    private let key: String
    private let defaultValue: Value
    private let defaults: UserDefaults
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    /// The wrapped value of the property value used to directly access the value
    public var wrappedValue: Value {
        get {
            guard let data = defaults.object(forKey: key) as? Data else { return defaultValue }
            guard let value = try? decoder.decode(Value.self, from: data) else { return defaultValue }

            return value
        }

        set {
            guard let data = try? encoder.encode(newValue) else { return }

            defaults.set(data, forKey: key)
        }
    }

    /// The default initializer for `UserDefault`
    ///
    /// - Parameter key: The key associated with storing the value inside the UserDefaults
    /// - Parameter defaultValue: The default value, that is used if no value is associated with the given key
    /// - Parameter defaults: The `UserDefaults` instance used to persist the data
    /// - Parameter decoder: The `JSONDecoder` used to decode the value from user defaults
    /// - Parameter encoder: The `JSONEncoder` used to encode the value to user defaults
    public init(
        key: String,
        defaultValue: @autoclosure () -> Value,
        defaults: UserDefaults = .standard,
        decoder: JSONDecoder = .init(),
        encoder: JSONEncoder = .init()
    ) {
        self.key = key
        self.defaultValue = defaultValue()
        self.defaults = defaults
        self.decoder = decoder
        self.encoder = encoder
    }
}
