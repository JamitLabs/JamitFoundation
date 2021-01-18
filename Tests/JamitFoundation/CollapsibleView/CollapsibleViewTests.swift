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
        collapsibleView.model = createBasicCollapsibleViewModel()
        isRecording = true
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
        assertSnapshot(matching: viewController, as: .recursiveDescription(on: .iPhoneX))
    }

    func testManyCollapsibelViews() {
        let titleDescription = "testManyCollapsibleViews"
        let viewController: UIViewController = .init()
        viewController.view.addSubview(collapsibleView)

        collapsibleView.frame = viewController.view.frame
        collapsibleView.model = CollapsibleViewModel<DefaultCollapsibleHeaderViewModel>(
            headerViewModel: .init(
                title: titleDescription,
                titleFont: UIFont.systemFont(ofSize: 10),
                arrowAnimationDuration: 0
            ),
            items: [
                CollapsibleElementView(backgroundColor: .red, height: 50, text: "Item 1"),
                CollapsibleElementView(backgroundColor: .green, height: 120, text: "Item 2"),
                CollapsibleElementView(backgroundColor: .red, height: 50, text: "Item 3"),
                CollapsibleElementView(backgroundColor: .green, height: 120, text: "Item 4"),
                CollapsibleElementView(backgroundColor: .red, height: 50, text: "Item 5"),
                CollapsibleElementView(backgroundColor: .green, height: 120, text: "Item 6"),
                CollapsibleElementView(backgroundColor: .red, height: 50, text: "Item 7"),
                CollapsibleElementView(backgroundColor: .green, height: 120, text: "Item 8"),
                CollapsibleElementView(backgroundColor: .red, height: 50, text: "Item 9"),
//                CollapsibleElementView(backgroundColor: .green, height: 120, text: "Item 10"),
//                CollapsibleElementView(backgroundColor: .red, height: 50, text: "Item 11"),
//                CollapsibleElementView(backgroundColor: .green, height: 120, text: "Item 12"),
            ],
            isCollapsed: true,
            animationDuration: 0.5
        )
        isRecording = true
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
        assertSnapshot(matching: viewController, as: .recursiveDescription(on: .iPhoneX))
    }

    func testModelItemChanges() throws {
        XCTAssertTrue(collapsibleView.model.items.count == collapsibleView.stackViewSize())

        let viewController: UIViewController = .init()
        viewController.view.addSubview(collapsibleView)
        collapsibleView.frame = viewController.view.frame

        collapsibleView.model = createBasicCollapsibleViewModel()
        isRecording = true
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
        XCTAssertTrue(collapsibleView.model.items.count == collapsibleView.stackViewSize())
    }

    func testModelItemsHiddenState() {
        collapsibleView.model = createBasicCollapsibleViewModel()

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
        collapsibleView.model = createBasicCollapsibleViewModel()

        // TODO: Check, if all items are collapsed

        collapsibleView.model = CollapsibleViewModel(
            headerViewModel: .init(
                title: "title",
                titleFont: UIFont.systemFont(ofSize: 20),
                arrowAnimationDuration: 0.5
            ),
            items: [
                CollapsibleElementView(backgroundColor: .red, height: 50, text: "Item 1"),
                CollapsibleElementView(backgroundColor: .green, height: 120, text: "Item 2"),
                CollapsibleElementView(backgroundColor: .red, height: 50, text: "Item 3"),
                CollapsibleElementView(backgroundColor: .green, height: 120, text: "Item 4"),
            ],
            isCollapsed: false,
            animationDuration: 0.5
        )

        // TODO: Check, if all items are not collapsed any more
    }

    func testMultipleCollapsibleViews() {
        // create 2 collapsible views and put them in one vC
    }

    func createBasicCollapsibleViewModel() -> CollapsibleViewModel<DefaultCollapsibleHeaderViewModel> {
        var model =  CollapsibleViewModel<headerViewModel>(
            headerViewModel: .init(
                title: "title",
                titleFont: UIFont.systemFont(ofSize: 20),
                arrowAnimationDuration: 0.5
            ),
            items: [
                CollapsibleElementView(backgroundColor: .red, height: 50, text: "Item 1"),
                CollapsibleElementView(backgroundColor: .green, height: 120, text: "Item 2"),
                CollapsibleElementView(backgroundColor: .red, height: 50, text: "Item 3"),
                CollapsibleElementView(backgroundColor: .green, height: 120, text: "Item 4"),
            ],
            isCollapsed: true,
            animationDuration: 0.5
        )
        return model
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        self.collapsibleView = nil
    }
}
