//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import TimePickerView
import UIKit

final class TimePickerViewController: StatefulViewController<TimePickerViewControllerViewModel> {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var timePickerContainerView: UIView!
    
    private lazy var timePickerView: TimePickerView = .instantiate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "TimePickerViewController"
        
        timePickerView.translatesAutoresizingMaskIntoConstraints = false
        timePickerContainerView.addSubview(timePickerView)

        timePickerView.leadingAnchor.constraint(equalTo: timePickerContainerView.leadingAnchor).isActive = true
        timePickerView.trailingAnchor.constraint(equalTo: timePickerContainerView.trailingAnchor).isActive = true
        timePickerView.topAnchor.constraint(equalTo: timePickerContainerView.topAnchor).isActive = true
        timePickerView.bottomAnchor.constraint(equalTo: timePickerContainerView.bottomAnchor).isActive = true
    }

    override func didChangeModel() {
        super.didChangeModel()

        titleLabel.text = model.title

        timePickerView.model = .init(
            hourLabel: NSLocalizedString("TIME_PICKER_VIEW_CONTROLLER.TIME_PICKER_HOUR.TITLE", comment: ""),
            hoursLabel: NSLocalizedString("TIME_PICKER_VIEW_CONTROLLER.TIME_PICKER_HOURS.TITLE", comment: ""),
            minutesLabel: NSLocalizedString("TIME_PICKER_VIEW_CONTROLLER.TIME_PICKER_MINUTES.TITLE", comment: ""),
            font: .systemFont(ofSize: 20.0),
            maximumHours: 23,
            maximumMinutes: 59,
            selectedHour: model.selectedHour,
            selectedMinute: model.selectedMinute
        ) { result in
                print(result)
        }
    }
}
