@testable import UserDefaults
import XCTest

class UserDefaultsTests: XCTestCase {
    let key: String = "jamitFoundation.userDefaults.Tests.sampleKey"
    let sampleDefaultValue: String = "Sample Default"
    let sampleValue: String = "Sample"
    let userDefaults: MockUserDefaults = .init()

    func testSaveValue() throws {
        let userDefaults: MockUserDefaults = .init()
        var value: UserDefault<String> = .init(key: key, defaultValue: self.sampleDefaultValue, defaults: userDefaults)

        XCTAssertEqual(sampleDefaultValue, value.wrappedValue)

        value.wrappedValue = sampleValue
        XCTAssertTrue(userDefaults.isValueSet)
        XCTAssertEqual(sampleValue, value.wrappedValue)
    }
}
