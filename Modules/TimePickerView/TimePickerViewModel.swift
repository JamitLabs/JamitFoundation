import JamitFoundation
import UIKit

struct TimePickerViewModel: ViewModelProtocol {
    typealias TimeComponent = (hours: Int, minutes: Int)
    typealias ComponentSelectionCallback = (TimeComponent) -> Void

    let hourLabel: String
    let hoursLabel: String
    let minutesLabel: String
    let font: UIFont
    
    var maximumHours: Int
    var maximumMinutes: Int
    let didSelectComponents: ComponentSelectionCallback

    init(
        hourLabel: String = Self.default.hourLabel,
        hoursLabel: String = Self.default.hoursLabel,
        minutesLabel: String = Self.default.minutesLabel,
        font: UIFont = Self.default.font,
        maximumHours: Int = Self.default.maximumHours,
        maximumMinutes: Int = Self.default.maximumMinutes,
        didSelectComponents: @escaping ComponentSelectionCallback = Self.default.didSelectComponents
    ) {
        self.hourLabel = hourLabel
        self.hoursLabel = hoursLabel
        self.minutesLabel = minutesLabel
        self.font = font
        self.maximumHours = maximumHours
        self.maximumMinutes = maximumMinutes
        self.didSelectComponents = didSelectComponents
    }
}

extension TimePickerViewModel {
    static let `default`: TimePickerViewModel = .init(
        hourLabel: "",
        hoursLabel: "",
        minutesLabel: "",
        font: .systemFont(ofSize: 20),
        maximumHours: 23,
        maximumMinutes: 59,
        didSelectComponents: { _ in }
    )
}
