import Foundation
import JamitFoundation
import UIKit

/// A stateful view which adds paged scroll behaviour to an embedded `ContentView`.
///
/// Example:
/// ```swift
/// // Represents an image view with paged scroll behaviour.
/// let imageSourceURLs: [URL] = <#image sources#>
/// let contentView = PageView<ImageView>.instantiate()
///
/// contentView.model = .init(pages: imageSourceURLs.map { .url($0) })
/// ```
public final class PageView<ContentView: StatefulViewProtocol>: StatefulView<PageViewModel<ContentView.Model>>, UIScrollViewDelegate {
    private lazy var scrollView: UIScrollView = .instantiate()
    private lazy var contentViews: [ContentView] = []
    private var contentViewIndex: Int = 0

    public override func viewDidLoad() {
        super.viewDidLoad()

        addSubview(scrollView)

        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.constraintEdgesToParent()
    }

    public override func didChangeModel() {
        super.didChangeModel()

        switch model.axis {
        case .horizontal:
            scrollView.alwaysBounceHorizontal = true
            scrollView.alwaysBounceVertical = false

        case .vertical:
            scrollView.alwaysBounceHorizontal = false
            scrollView.alwaysBounceVertical = true
        }

        if model.pages.count < contentViews.count {
            let removedIndices = model.pages.count ..< contentViews.count
            contentViews[removedIndices].forEach { $0.removeFromSuperview() }
            contentViews.removeSubrange(removedIndices)
        } else if contentViews.count < model.pages.count {
            let addedIndices = contentViews.count ..< model.pages.count
            addedIndices.forEach { _ in
                let view: ContentView = .instantiate()
                contentViews.append(view)
                scrollView.addSubview(view)
            }
        }

        contentViews.enumerated().forEach { index, view in
            view.model = model.pages[index]
        }

        updateContentLayout()
    }

    private func updateContentLayout() {
        let totalContentDimension = CGFloat(contentViews.count) * min(bounds.width, bounds.height)
        scrollView.contentSize = CGSize(
            width: model.axis == .horizontal ? totalContentDimension : bounds.width,
            height: model.axis == .vertical ? totalContentDimension : bounds.height
        )

        let initialFrame = bounds
        contentViews.enumerated().forEach { index, view in
            view.frame = initialFrame.offsetBy(
                dx: model.axis == .horizontal ? CGFloat(index) * initialFrame.width : 0,
                dy: model.axis == .vertical ? CGFloat(index) * initialFrame.height : 0
            )
        }
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let newContentViewIndex: Int
        switch model.axis {
        case .horizontal:
            newContentViewIndex = bounds.width > 0 ? Int(round(scrollView.contentOffset.x / bounds.width)) : 0

        case .vertical:
            newContentViewIndex = bounds.height > 0 ? Int(round(scrollView.contentOffset.y / bounds.height)) : 0
        }

        if contentViewIndex != newContentViewIndex {
            contentViewIndex = newContentViewIndex
            model.onPageIndexChanged(contentViewIndex)
        }
    }
}
