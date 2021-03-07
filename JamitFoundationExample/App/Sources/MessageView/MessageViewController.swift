//  Copyright © 2021 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

final class MessageViewController: StatefulViewController<MessageViewControllerViewModel>{
    private let messageViewPresenter: MessageViewPresenter = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "MessageViewController"
    }

    @IBAction func showMessageViewFromTop() {
        messageViewPresenter.showInfo(
            withTitle: "MessageView From top",
            andMessage: "This is a message view presented from top without a background view",
            origin: .top,
            shouldHaveBackgroundView: false
        ) {
           print("Did dismiss messag view from top without background view")
        }
    }

    @IBAction func showMessageViewFromBottom() {
        messageViewPresenter.showInfo(
            withTitle: "MessageView From bottom",
            andMessage: "This is a message view presented from bottom without a background view",
            origin: .bottom,
            shouldHaveBackgroundView: false
        ) {
           print("Did dismiss messag view from bottom without background view")
        }
    }

    @IBAction func showMessageViewFromTopWithBackground() {
        messageViewPresenter.showInfo(
            withTitle: "MessageView From top with background view",
            andMessage: "This is a message view presented from top with a background view",
            origin: .top,
            shouldHaveBackgroundView: true,
            with: UIColor.black.withAlphaComponent(0.3)
        ) {
           print("Did dismiss messag view from top with background view")
        }
    }

    @IBAction func showMessageViewFromBottomWithBackground() {
        messageViewPresenter.showInfo(
            withTitle: "MessageView From bottom with background view",
            andMessage: "This is a message view presented from bottom with a background view",
            origin: .top,
            shouldHaveBackgroundView: true,
            with: UIColor.black.withAlphaComponent(0.3)
        ) {
           print("Did dismiss messag view from bottom with background view")
        }
    }
}
