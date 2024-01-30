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
        
        timePickerContainerView.addSubview(timePickerView)

        timePickerView.constraintEdgesToParent()
    }

    override func didChangeModel() {
        super.didChangeModel()

        titleLabel.text = model.title

        timePickerView.model = .init(
            hourLabelTitle: NSLocalizedString("TIME_PICKER_VIEW_CONTROLLER.TIME_PICKER_HOUR.TITLE", comment: ""),
            hoursLabelTitle: NSLocalizedString("TIME_PICKER_VIEW_CONTROLLER.TIME_PICKER_HOURS.TITLE", comment: ""),
            minutesLabelTitle: NSLocalizedString("TIME_PICKER_VIEW_CONTROLLER.TIME_PICKER_MINUTES.TITLE", comment: ""),
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
