// Copyright © 2020 Jamit Labs GmbH. All rights reserved.

@testable import JamitFoundation
import XCTest
import SnapshotTesting

class CollapsibleViewTests: XCTestCase {

    private var collapsibleView: CollapsibleView<DefaultCollapsibleHeaderView>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        collapsibleView = .instantiate()
    }

    func testCollapsibleView() {
        let viewController: UIViewController = .init()
        viewController.view.addSubview(collapsibleView)
        collapsibleView.frame = viewController.view.frame
        collapsibleView.model = CollapsibleViewModel(
            headerViewModel: .init(
                title: "title",
                titleFont: UIFont.systemFont(ofSize: 20),
                arrowAnimationDuration: 0.5
            ),
            items: [
                CollapsibleElementView(backgroundColor: .red, height: 50),
                CollapsibleElementView(backgroundColor: .blue, height: 150),
            ],
            isCollapsed: true,
            animationDuration: 0.5
        )
        assertSnapshot(matching: viewController, as: .image)
    }

    func testManyCollapsibelViews() {
        let viewController: UIViewController = .init()
        viewController.view.addSubview(collapsibleView)
        collapsibleView.frame = viewController.view.frame
        collapsibleView.model = CollapsibleViewModel(
            headerViewModel: .init(
                title: "title testa",
                titleFont: UIFont.systemFont(ofSize: 20),
                arrowAnimationDuration: 0
            ),
            items: [
                CollapsibleElementView(backgroundColor: .red, height: 50),
                CollapsibleElementView(backgroundColor: .green, height: 120),
                CollapsibleElementView(backgroundColor: .red, height: 50),
                CollapsibleElementView(backgroundColor: .green, height: 120),
                CollapsibleElementView(backgroundColor: .red, height: 50),
                CollapsibleElementView(backgroundColor: .green, height: 120),
                CollapsibleElementView(backgroundColor: .red, height: 50),
                CollapsibleElementView(backgroundColor: .green, height: 120),
                CollapsibleElementView(backgroundColor: .red, height: 50),
                CollapsibleElementView(backgroundColor: .green, height: 120),
                CollapsibleElementView(backgroundColor: .red, height: 50),
                CollapsibleElementView(backgroundColor: .green, height: 120),
            ],
            isCollapsed: true,
            animationDuration: 0.5
        )
        // isRecording = true
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
        // TODO: Check, if header title is "title"

    }

    func testModelItemChanges() throws {
        XCTAssertTrue(collapsibleView.model.items.count == collapsibleView.stackViewSize())

        collapsibleView.model = CollapsibleViewModel(
            headerViewModel: .init(
                title: "title",
                titleFont: UIFont.systemFont(ofSize: 20),
                arrowAnimationDuration: 0.5
            ),
            items: [
                UIView(),
                UIView(),
                UIView(),
                UIView()
            ],
            isCollapsed: true,
            animationDuration: 0.5
        )

        XCTAssertTrue(collapsibleView.model.items.count == collapsibleView.stackViewSize())
        // TODO: are items in the coorect order? maybe
    }

    func testModelItemsHiddenState() {
        collapsibleView.model = CollapsibleViewModel(
            headerViewModel: .init(
                title: "title",
                titleFont: UIFont.systemFont(ofSize: 20),
                arrowAnimationDuration: 0.5
            ),
            items: [
                UIView(),
                UIView(),
                UIView(),
                UIView()
            ],
            isCollapsed: true,
            animationDuration: 0.5
        )

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

    func testModelisCollapsed() {
        collapsibleView.model = CollapsibleViewModel(
            headerViewModel: .init(
                title: "title",
                titleFont: UIFont.systemFont(ofSize: 20),
                arrowAnimationDuration: 0.5
            ),
            items: [
                UIView(),
                UIView(),
                UIView(),
                UIView()
            ],
            isCollapsed: true,
            animationDuration: 0.5
        )

        // TODO: Check, if all items are collapsed

        collapsibleView.model = CollapsibleViewModel(
            headerViewModel: .init(
                title: "title",
                titleFont: UIFont.systemFont(ofSize: 20),
                arrowAnimationDuration: 0.5
            ),
            items: [
                UIView(),
                UIView(),
                UIView(),
                UIView()
            ],
            isCollapsed: false,
            animationDuration: 0.5
        )

        // TODO: Check, if all items are not collapsed any more
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        self.collapsibleView = nil
    }
}
