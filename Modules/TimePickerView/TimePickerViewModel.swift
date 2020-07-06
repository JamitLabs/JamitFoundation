import JamitFoundation
import UIKit

/// The state view model for `TimePickerView`.
public struct TimePickerViewModel: ViewModelProtocol {
    /// A type definition which contains the selected hours and minutes.
    public typealias TimeComponent = (hours: Int, minutes: Int)
    /// A closure type definition for the selection of a time picker component callback.
    public typealias ComponentSelectionCallback = (TimeComponent) -> Void

    /// The string which will be used to place behind the hour component when only one hour is selected.
    public let hourLabel: String
    /// The string which will be used to place behind the hour component when more than one hour is selected.
    public let hoursLabel: String
    /// The string which will be used to place behind the minutes component.
    public let minutesLabel: String
    /// The font used within the time picker components.
    public let font: UIFont
    
    /// The maximum amount of hours a user can pick.
    public let maximumHours: Int
    /// The maximum amount of minutes a user can pick.
    public let maximumMinutes: Int
    /// The selected hour.
    public let selectedHour: Int
    /// The selected minute.
    public let selectedMinute: Int
    
    /// The callback when the user selects a component, will be called every time the minute or hour component will be changed.
    public let didSelectComponents: ComponentSelectionCallback

    /// The default initializer of `TimePickerViewModel`.
    ///
    /// - Parameter hourLabel: The string which will be used to place behind the hour component when only one hour is selected.
    /// - Parameter hoursLabel: The string which will be used to place behind the hour component when more than one hour is selected.
    /// - Parameter minutesLabel: The scroll axis for the paging behaviour.
    /// - Parameter hourLabel: The string which will be used to place behind the minutes component.
    /// - Parameter font: The font used within the time picker components.
    /// - Parameter maximumHours: The maximum amount of hours a user can pick.
    /// - Parameter maximumMinutes: The maximum amount of minutes a user can pick.
    /// - Parameter selectedHour: The selected hour.
    /// - Parameter selectedMinute: The selected minute.
    /// - Parameter didSelectComponents: The callback when the user selects a component, will be called every time the minute or hour component will be changed.
    public init(
        hourLabel: String = Self.default.hourLabel,
        hoursLabel: String = Self.default.hoursLabel,
        minutesLabel: String = Self.default.minutesLabel,
        font: UIFont = Self.default.font,
        maximumHours: Int = Self.default.maximumHours,
        maximumMinutes: Int = Self.default.maximumMinutes,
        selectedHour: Int = Self.default.selectedHour,
        selectedMinute: Int = Self.default.selectedMinute,
        didSelectComponents: @escaping ComponentSelectionCallback = Self.default.didSelectComponents
    ) {
        self.hourLabel = hourLabel
        self.hoursLabel = hoursLabel
        self.minutesLabel = minutesLabel
        self.font = font
        self.maximumHours = maximumHours
        self.maximumMinutes = maximumMinutes
        self.selectedHour = selectedHour
        self.selectedMinute = selectedMinute
        self.didSelectComponents = didSelectComponents
    }
}

extension TimePickerViewModel {
    /// The default state of `TimePickerViewModel`.
    public static let `default`: TimePickerViewModel = .init(
        hourLabel: "hour",
        hoursLabel: "hours",
        minutesLabel: "minutes",
        font: .systemFont(ofSize: 20),
        maximumHours: 23,
        maximumMinutes: 59,
        selectedHour: 0,
        selectedMinute: 0,
        didSelectComponents: { _ in }
    )
}
