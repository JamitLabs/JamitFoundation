//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import UIKit

final class TabBarContentViewController: UIViewController, TabBarViewControllerProtocol {
    var tabBarItemView: TabBarItemView = .init()
    var shouldShowModally: Bool = true
    var backgroundColor: UIColor = .white

    private lazy var button: UIButton = .init()
    private lazy var contentView: UIView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(button)
        button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        contentView.backgroundColor = backgroundColor

        let buttonTitle: String = shouldShowModally ? "Present" : "Push"
        button.setTitle(buttonTitle, for: .normal)

        let action = shouldShowModally ? #selector(presentViewController) : #selector(pushViewController)
        button.addTarget(self, action: action, for: .primaryActionTriggered)
    }

    @objc
    private func presentViewController() {
        let viewController: UIViewController = .init()
        viewController.view.backgroundColor = .darkGray
        present(viewController, animated: true, completion: nil)
    }

    @objc
    private func pushViewController() {
        let viewController: TabBarContentViewController = .init()
        viewController.shouldShowModally = false
        viewController.backgroundColor = .orange
        navigationController?.pushViewController(viewController, animated: true)
    }
}
