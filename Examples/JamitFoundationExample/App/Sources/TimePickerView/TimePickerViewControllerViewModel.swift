//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import Foundation
import JamitFoundation

struct TimePickerViewControllerViewModel: ViewModelProtocol {
    let title: String
    let selectedHour: Int
    let selectedMinute: Int

    init(
        title: String = Self.default.title,
        selectedHour: Int = Self.default.selectedHour,
        selectedMinute: Int = Self.default.selectedMinute
    ) {
        self.title = title
        self.selectedHour = selectedHour
        self.selectedMinute = selectedMinute
    }
}

extension TimePickerViewControllerViewModel {
    static var `default`: TimePickerViewControllerViewModel = .init(
        title: "",
        selectedHour: 0,
        selectedMinute: 0
    )
}
