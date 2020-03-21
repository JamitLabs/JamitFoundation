import UIKit

public final class SelectableView<ContenView: StatefulViewProtocol>: StatefulView<SelectableViewModel<ContenView.Model>> {
    public var isSelected: Bool = false {
        didSet {
            model.onSelected(isSelected)
        }
    }

    public private(set) lazy var view: ContenView = .instantiate()

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        isUserInteractionEnabled = true
    }

    public override func didChangeModel() {
        super.didChangeModel()

        isSelected = model.isSelected
        view.model = model.content
    }
}
