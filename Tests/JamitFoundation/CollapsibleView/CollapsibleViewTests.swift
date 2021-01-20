// Copyright © 2020 Jamit Labs GmbH. All rights reserved.

@testable import JamitFoundation
import XCTest
import SnapshotTesting

class CollapsibleViewTests: XCTestCase {

    private var collapsibleView: CollapsibleView<DefaultCollapsibleHeaderView>!

    private static let basicCollapsibleViewItems = [
        CollapsibleElementView(backgroundColor: .red, height: 50, text: "Item 1"),
        CollapsibleElementView(backgroundColor: .green, height: 120, text: "Item 2"),
        CollapsibleElementView(backgroundColor: .red, height: 50, text: "Item 3"),
        CollapsibleElementView(backgroundColor: .green, height: 120, text: "Item 4"),
    ]

    override func setUpWithError() throws {
        try super.setUpWithError()
        collapsibleView = .instantiate()
    }

    func testCollapsibleView() {
        let viewController: CollapsibleViewController = makeViewControllerWithCollapsibleView()
//        isRecording = true
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
        assertSnapshot(matching: viewController, as: .recursiveDescription(on: .iPhoneX))
    }

    func testManyCollapsibelViews() {
        let titleDescription = "testManyCollapsibleViews"

        let collapsibleViewItems = [
            CollapsibleElementView(backgroundColor: .red, height: 50, text: "Item 1"),
            CollapsibleElementView(backgroundColor: .green, height: 120, text: "Item 2"),
            CollapsibleElementView(backgroundColor: .red, height: 50, text: "Item 3"),
            CollapsibleElementView(backgroundColor: .green, height: 120, text: "Item 4"),
            CollapsibleElementView(backgroundColor: .red, height: 50, text: "Item 5"),
            CollapsibleElementView(backgroundColor: .green, height: 120, text: "Item 6"),
            CollapsibleElementView(backgroundColor: .red, height: 50, text: "Item 7"),
            CollapsibleElementView(backgroundColor: .green, height: 120, text: "Item 8"),
            CollapsibleElementView(backgroundColor: .red, height: 50, text: "Item 9"),
            CollapsibleElementView(backgroundColor: .green, height: 120, text: "Item 10"),
            CollapsibleElementView(backgroundColor: .red, height: 50, text: "Item 11"),
            CollapsibleElementView(backgroundColor: .green, height: 120, text: "Item 12"),
            CollapsibleElementView(backgroundColor: .red, height: 50, text: "Item 13"),
            CollapsibleElementView(backgroundColor: .green, height: 120, text: "Item 14"),
            CollapsibleElementView(backgroundColor: .red, height: 50, text: "Item 15"),
            CollapsibleElementView(backgroundColor: .green, height: 120, text: "Item 16"),
            CollapsibleElementView(backgroundColor: .red, height: 50, text: "Item 17"),
            CollapsibleElementView(backgroundColor: .green, height: 120, text: "Item 18"),
            CollapsibleElementView(backgroundColor: .red, height: 50, text: "Item 19"),
            CollapsibleElementView(backgroundColor: .green, height: 120, text: "Item 20")
        ]

        let viewController: CollapsibleViewController = makeViewControllerWithCollapsibleView(with: collapsibleViewItems, title: titleDescription)
//        isRecording = true
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
        assertSnapshot(matching: viewController, as: .recursiveDescription(on: .iPhoneX))
    }

    func testModelItemChanges() throws {
        // add a collapsibleView item
        XCTAssertTrue(collapsibleView.model.items.count == collapsibleView.stackViewSize())

        let viewController: CollapsibleViewController = makeViewControllerWithCollapsibleView()

//        isRecording = true
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
        XCTAssertTrue(collapsibleView.model.items.count == collapsibleView.stackViewSize())
        // TODO: check here
        // TODO: XCTAssert contain checken

        // TODO: modify a collapsibleView item
        let modifiedItems = [
            CollapsibleElementView(backgroundColor: .blue, height: 100, text: "Item 1"),
            CollapsibleElementView(backgroundColor: .yellow, height: 100, text: "Item 2"),
            CollapsibleElementView(backgroundColor: .orange, height: 100, text: "Item 3")
        ]

        collapsibleView.model = createBasicCollapsibleViewModel(collapsibleViewIitems: modifiedItems)
        assertSnapshot(matching: viewController, as: .image(on: .iPhoneX))
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

        XCTAssertFalse(collapsibleView.model.isCollapsed)

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
            isCollapsed: true,
            animationDuration: 0.5
        )

        XCTAssertTrue(collapsibleView.model.isCollapsed)
    }

    func makeViewControllerWithCollapsibleView(with items: [UIView] = basicCollapsibleViewItems, title: String = "add Title") -> CollapsibleViewController {
        let viewController: CollapsibleViewController = .instantiate()
        viewController.model = createBasicViewControllerModel()
        viewController.view.addSubview(collapsibleView)

        collapsibleView.translatesAutoresizingMaskIntoConstraints = false
        collapsibleView.topAnchor.constraint(equalTo: viewController.view.topAnchor).isActive = true
        collapsibleView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor).isActive = true
        collapsibleView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor).isActive = true

        collapsibleView.model = createBasicCollapsibleViewModel(collapsibleViewIitems: items, title: title)
        return viewController
    }

    func createBasicCollapsibleViewModel(collapsibleViewIitems: [UIView] = basicCollapsibleViewItems, title: String = "add Title") -> CollapsibleViewModel<DefaultCollapsibleHeaderViewModel> {
        let model =  CollapsibleViewModel<DefaultCollapsibleHeaderViewModel>(
            headerViewModel: .init(
                title: title,
                titleFont: UIFont.systemFont(ofSize: 20),
                arrowAnimationDuration: 0.5
            ),
            items: collapsibleViewIitems,
            isCollapsed: true,
            animationDuration: 0.5
        )
        return model
    }

    func createBasicViewControllerModel() -> CollapsibleViewControllerViewModel {
        let model: CollapsibleViewControllerViewModel = .init(
            headerTitles: [
                "hey"
            ],
            headerTitleFont: .systemFont(ofSize: 16.0)
        )
        return model
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        self.collapsibleView = nil
    }
}
