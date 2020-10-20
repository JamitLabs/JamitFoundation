// Copyright © 2020 Jamit Labs GmbH. All rights reserved.

@testable import JamitFoundation
import XCTest

class CollapsibleViewTests: XCTestCase {

    private var collapsibleView: CollapsibleView<DefaultCollapsibleHeaderView>!

    override func setUpWithError() throws {
        try super.setUpWithError()

        collapsibleView = .instantiate()
    }

    func testModelChangeDeployments() throws {
        // IF CASE: add two elements of stack view

        XCTAssertTrue(collapsibleView.model.items.count == collapsibleView.stackViewSize())

        collapsibleView.model = CollapsibleViewModel(
            headerViewModel: .init(
                title: "title",
                titleFont: UIFont.systemFont(ofSize: 20),
                arrowAnimationDuration: 0.5
            ),
            items: [
                UIView(),
                UIView()
            ],
            isCollapsed: true,
            animationDuration: 0.5
        )

        XCTAssertTrue(collapsibleView.model.items.count == collapsibleView.stackViewSize())

        // ELSE CASE: just modify isHidden State

        XCTAssertFalse(collapsibleView.isHidden)
        collapsibleView.model.isCollapsed = false
        collapsibleView.model.items.forEach { view in
            XCTAssertTrue(view.isHidden)
        }
        collapsibleView.model.isCollapsed = true
        collapsibleView.model.items.forEach { view in
            XCTAssertFalse(view.isHidden)
        }
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        self.collapsibleView = nil
    }
}
