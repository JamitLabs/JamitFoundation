import Foundation

final class MockUserDefaults: UserDefaults {
    var isValueSet: Bool = false
    var value: Any?

    convenience init() {
        self.init(suiteName: "jamitFoundation.userDefaults.tests.mockUserDefaults.suite")!
    }

    override init?(suiteName suitename: String?) {
        UserDefaults().removePersistentDomain(forName: suitename!)

        super.init(suiteName: suitename)
    }

    override func set(_ value: Any?, forKey defaultName: String) {
        self.isValueSet = defaultName == "jamitFoundation.userDefaults.Tests.sampleKey"
        self.value = value
    }

    override func object(forKey defaultName: String) -> Any? {
        value
    }
}

