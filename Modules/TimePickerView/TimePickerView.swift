import JamitFoundation
import UIKit

/// A stateful view which adds a time picker view to an embedded `ContentView`.
///
/// Example:
/// ```swift
/// let model: TimePickerViewModel = .init(
///     hourLabel: "hour",
///     hoursLabel: "hours",
///     minutesLabel: "minutes",
///     font: .systemFont(ofSize: 20.0),
///     maximumHours: 23,
///     maximumMinutes: 59
/// ) { result in
///     ...
/// }
/// let contentView: TimePickerView = .instantiate()
/// contentView.model = model
/// ```
public final class TimePickerView: StatefulView<TimePickerViewModel> {
    private enum Constants {
        static let hoursLabelInset: CGFloat = 10.0
        static let minutesLabelInset: CGFloat = 25.0
        static let rowHeight: CGFloat = 30.0
    }
    
    private enum TimePickerComponent: Int, CaseIterable {
        case hours
        case minutes
    }

    private lazy var hoursLabel: UILabel = {
        let hoursLabel = UILabel()
        hoursLabel.font = model.font
        hoursLabel.textAlignment = .left
        hoursLabel.sizeToFit()

        return hoursLabel
    }()

    private lazy var minutesLabel: UILabel = {
        let minutesLabel = UILabel()
        minutesLabel.font = model.font
        minutesLabel.textAlignment = .left
        minutesLabel.sizeToFit()

        return minutesLabel
    }()

    private var pickerView: UIPickerView = .init()

    // MARK: - Methods
    public override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        addSubview(pickerView)

        pickerView.delegate = self
        pickerView.dataSource = self

        let minutesLayoutGuide = UILayoutGuide()
        addLayoutGuide(minutesLayoutGuide)
        minutesLayoutGuide.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        minutesLayoutGuide.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        minutesLayoutGuide.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1 / 3).isActive = true

        let hoursLayoutGuide = UILayoutGuide()
        addLayoutGuide(hoursLayoutGuide)
        hoursLayoutGuide.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        hoursLayoutGuide.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        hoursLayoutGuide.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true

        hoursLabel.translatesAutoresizingMaskIntoConstraints = false
        pickerView.addSubview(hoursLabel)

        hoursLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        hoursLabel.leadingAnchor.constraint(equalTo: hoursLayoutGuide.leadingAnchor, constant: Constants.hoursLabelInset).isActive = true

        minutesLabel.translatesAutoresizingMaskIntoConstraints = false
        pickerView.addSubview(minutesLabel)

        minutesLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        minutesLabel.leadingAnchor.constraint(equalTo: minutesLayoutGuide.trailingAnchor, constant: Constants.minutesLabelInset).isActive = true

        pickerView(pickerView, didSelectRow: 0, inComponent: TimePickerComponent.hours.rawValue)
        pickerView(pickerView, didSelectRow: 0, inComponent: TimePickerComponent.minutes.rawValue)
    }
}

extension TimePickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int { TimePickerComponent.allCases.count }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let timePickerComponent = TimePickerComponent(rawValue: component) else { return 0 }

        let zeroOffset: Int = 1
        switch timePickerComponent {
        case .hours: return model.maximumHours <= 0 ? 1 : model.maximumHours + zeroOffset
        case .minutes: return model.maximumMinutes <= 0 ? 1 : model.maximumMinutes + zeroOffset
        }
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard TimePickerComponent(rawValue: component) != nil else { return nil }

        return String(row)
    }

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let hoursComponent = pickerView.selectedRow(inComponent: TimePickerComponent.hours.rawValue)
        let minutesComponent = pickerView.selectedRow(inComponent: TimePickerComponent.minutes.rawValue)

        if let timeComponent = TimePickerComponent(rawValue: component) {
            switch timeComponent {
            case .hours:
                hoursLabel.text = row == 1 ? model.hourLabel: model.hoursLabel

            case .minutes:
                minutesLabel.text = model.minutesLabel
            }
        }

        model.didSelectComponents((hours: hoursComponent, minutes: minutesComponent))
    }

    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        Constants.rowHeight
    }

    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        guard let timePickerComponent = TimePickerComponent(rawValue: component) else { return nil }

        let text = String(row)
        let paragraphStyle = NSMutableParagraphStyle()

        switch timePickerComponent {
        case .hours:
            paragraphStyle.alignment = .left

        case .minutes:
            paragraphStyle.alignment = .center
        }

        let range: NSRange = .init(location: 0, length: text.count)
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttributes(
            [
                .paragraphStyle: paragraphStyle,
                .font: model.font
            ],
            range: range
        )

        return attributedString
    }

    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        bounds.width / 3.0
    }
}
