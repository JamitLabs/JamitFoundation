//  Copyright © 2021 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import MessageView
import UIKit

final class MessageViewController: StatefulViewController<MessageViewControllerViewModel>{
    private let messageViewPresenter: MessageViewPresenter = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "MessageViewController"
    }

    @IBAction func showMessageViewFromTop() {
        messageViewPresenter.show(
            withTitle: "MessageView From top",
            andMessage: "This is a message view presented from top without a background view",
            position: .top,
            shouldHaveBackgroundView: false
        ) {
           print("Did dismiss messag view from top without background view")
        }
    }

    @IBAction func showTimedMessageViewFromTop() {
        messageViewPresenter.show(
            withTitle: "Timed MessageView from top",
            andMessage: "This is a timed message view presented from top without a background view",
            position: .top,
            shouldHaveBackgroundView: false,
            hideOption: .timer(3)
        ) {
           print("Did dismiss messag view from top without background view")
        }
    }

    @IBAction func showMessageViewFromBottom() {
        messageViewPresenter.show(
            withTitle: "MessageView from bottom",
            andMessage: "This is a message view presented from bottom without a background view",
            position: .bottom,
            shouldHaveBackgroundView: false
        ) {
           print("Did dismiss messag view from bottom without background view")
        }
    }

    @IBAction func showTimedMessageViewFromBottom() {
        messageViewPresenter.show(
            withTitle: "Timed MessageView from bottom",
            andMessage: "This is a timed message view presented from bottom without a background view",
            position: .bottom,
            shouldHaveBackgroundView: false,
            hideOption: .timer(3)
        ) {
           print("Did dismiss messag view from bottom without background view")
        }
    }

    @IBAction func showMessageViewFromTopWithBackground() {
        messageViewPresenter.show(
            withTitle: "MessageView from top with background view",
            andMessage: "This is a message view presented from top with a background view",
            position: .top,
            shouldHaveBackgroundView: true,
            backgroundViewColor: UIColor.black.withAlphaComponent(0.3)
        ) {
           print("Did dismiss messag view from top with background view")
        }
    }

    @IBAction func showMessageViewFromBottomWithBackground() {
        messageViewPresenter.show(
            withTitle: "MessageView from bottom with background view",
            andMessage: "This is a message view presented from bottom with a background view",
            position: .bottom,
            shouldHaveBackgroundView: true,
            backgroundViewColor: UIColor.black.withAlphaComponent(0.3)
        ) {
           print("Did dismiss messag view from bottom with background view")
        }
    }

    @IBAction func dismissLatestMessageViewAnimated() {
        messageViewPresenter.dismissLatest()
    }

    @IBAction func dismissLatestMessageView() {
        messageViewPresenter.dismissLatest(animated: false)
    }

    @IBAction func dismissAllMessageViewsAnimated() {
        messageViewPresenter.dismissAllMessages()
    }

    @IBAction func dismissAllMessageViews() {
        messageViewPresenter.dismissAllMessages(animated: false)
    }
}
