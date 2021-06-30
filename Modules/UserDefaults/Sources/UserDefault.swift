import Foundation
import SwiftUI

///
/// `UserDefault` is a property wrapper that can be applied to any codable property to store it in the user defaults
///
/// Example:
/// ```swift
/// @UserDefault(key: "user_defaults.default.value_key", defaultValue: true)
/// var value: Bool
/// ```
@propertyWrapper
public class UserDefault<Value> where Value: Codable {
    /// Callback providing the default value, that is used if no value is associated with the given key
    public typealias DefaultValue = () -> Value

    private let key: String
    private let defaultValue: DefaultValue
    private let defaults: UserDefaults

    @available(iOS 13.0, *)
    public var projectedValue: Binding<Value> { return .init(get: { self.wrappedValue }, set: { self.wrappedValue = $0 }) }

    /// The wrapped value of the property value used to directly access the value
    public var wrappedValue: Value {
        get {
            guard let value = getValue() else {
                let value = defaultValue()
                setValue(value)

                return value
            }

            return value
        }

        set {
            setValue(newValue)
        }
    }

    /// The default initializer for `UserDefault`
    ///
    /// - Parameter key: The key associated with storing the value inside the UserDefaults
    /// - Parameter defaultValue: The default value, that is used if no value is associated with the given key
    /// - Parameter defaults: The UserDefaults instance
    public init(key: String, defaultValue: @autoclosure @escaping DefaultValue, defaults: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.defaults = defaults
    }

    private func setValue(_ newValue: Value) {
        do {
            let encoder = JSONEncoder()
            let encodedValue = try encoder.encode(newValue)

            defaults.set(encodedValue, forKey: key)
        } catch {
            NSLog("Encoding the value associated with the key: %@ threw an error: %@", key, error.localizedDescription)
        }
    }

    private func getValue() -> Value? {
        do {
            let decoder = JSONDecoder()
            guard let data = defaults.object(forKey: key) as? Data else { return nil }

            return try decoder.decode(Value.self, from: data)
        } catch {
            NSLog("Decoding the value associated with the key: %@ threw an error: %@", key, error.localizedDescription)
        }

        return nil
    }
}
