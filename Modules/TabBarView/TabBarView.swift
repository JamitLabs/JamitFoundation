//
//  File.swift
//  
//
//  Created by Raoul Schwagmeier on 10.03.20.
//

import JamitFoundation
import UIKit

final class TabBarView<ItemView: StatefulViewProtocol>: StatefulView<TabBarViewModel<ItemView.Model>> {
    // MARK: - Properties
    var selectedIndex: Int = 0 {
        didSet {
            model.onSelectedIndexChanged(selectedIndex)
        }
    }

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill

        return view
    }()

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    override func didChangeModel() {
        super.didChangeModel()

        stackView.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
            stackView.removeArrangedSubview(view)
        }

        model.items.enumerated().forEach { index, item in
            let itemView: ActionView<ItemView> = .instantiate()
            itemView.model = .init(content: model.items[index], action: { [weak self] in
            })

            stackView.addArrangedSubview(itemView)
        }
    }
}
