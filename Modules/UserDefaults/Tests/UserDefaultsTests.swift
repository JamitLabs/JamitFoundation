@testable import UserDefaults
import XCTest

class UserDefaultsTests: XCTestCase {
    let key: String = "jamitFoundation.userDefaults.Tests.sampleKey"
    let sampleDefaultValue: String = "Sample Default"
    let sampleValue: String = "Sample"
    let userDefaults: MockUserDefaults = .init()

    func testSaveValue() throws {
        let userDefaults: MockUserDefaults = .init()
        let value: UserDefault<String> = .init(key: key, defaultValue: self.sampleDefaultValue, defaults: userDefaults)

        XCTAssertEqual(sampleDefaultValue, value.wrappedValue)
        XCTAssertTrue(userDefaults.isValueSet)

        value.wrappedValue = sampleValue

        XCTAssertEqual(sampleValue, value.wrappedValue)
    }
}
