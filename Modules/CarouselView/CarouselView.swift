import Foundation
import JamitFoundation
import UIKit

/// A stateful view which adds carousel scroll behaviour to an embedded `ContentView`.
///
/// Example:
/// ```swift
/// // Represents an image view with paged scroll behaviour.
/// let imageSourceURLs: [URL] = <#image sources#>
/// let contentView = CarouselView<ImageView>.instantiate()
///
/// contentView.model = .init(pages: imageSourceURLs.map { .url($0) })
/// ```
public final class CarouselView<ContentView: StatefulViewProtocol>: StatefulView<CarouselViewModel<ContentView.Model>>, UIScrollViewDelegate {
    private lazy var scrollView: UIScrollView = .instantiate()
    private lazy var contentViews: [ContentView] = []
    private lazy var leftContentViewPlaceholder: ContentView = .instantiate()
    private lazy var rightContentViewPlaceholder: ContentView = .instantiate()
    private lazy var leftOffscreenContentViewPlaceholder: ContentView = .instantiate()
    private lazy var rightOffscreenContentViewPlaceholder: ContentView = .instantiate()

    private var contentViewIndex: Int = 0
    private var isScrollViewDidScrollObservationEnabled: Bool = true

    private var allContentViews: [ContentView] {
        return [leftContentViewPlaceholder] + contentViews + [rightContentViewPlaceholder]
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.clipsToBounds = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scrollView.addSubview(leftContentViewPlaceholder)
        scrollView.addSubview(rightContentViewPlaceholder)
        scrollView.addSubview(leftOffscreenContentViewPlaceholder)
        scrollView.addSubview(rightOffscreenContentViewPlaceholder)
    }

    public override func didChangeModel() {
        super.didChangeModel()

        scrollView.alwaysBounceHorizontal = true
        scrollView.alwaysBounceVertical = false

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

        if !model.pages.isEmpty {
            scrollView.isHidden = false
            leftContentViewPlaceholder.model = model.pages[modIndex(model.pages.count - 1, model.pages.count)]
            rightContentViewPlaceholder.model = model.pages[0]
            leftOffscreenContentViewPlaceholder.model = model.pages[modIndex(model.pages.count - 2, model.pages.count)]
            rightOffscreenContentViewPlaceholder.model = model.pages[modIndex(1, model.pages.count)]
        } else {
            scrollView.isHidden = true
        }

        updateContentLayout()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        updateContentLayout()
    }

    private func updateContentLayout() {
        scrollView.contentSize = CGSize(
            width: bounds.width * CGFloat(contentViews.count + 2),
            height: bounds.height
        )
        scrollView.contentOffset = CGPoint(x: bounds.width, y: 0)

        let initialFrame = bounds
        allContentViews.enumerated().forEach { index, view in
            let containerFrame = initialFrame.offsetBy(
                dx: CGFloat(index) * initialFrame.width,
                dy: 0
            )

            view.frame = CGRect(
                x: containerFrame.origin.x + model.pageInset.left,
                y: containerFrame.origin.y + model.pageInset.top,
                width: containerFrame.size.width - model.pageInset.left - model.pageInset.right,
                height: containerFrame.size.height - model.pageInset.top - model.pageInset.bottom
            )
        }

        leftOffscreenContentViewPlaceholder.frame = calculateLeftOffscreenContentViewPlaceholderFrame()
        rightOffscreenContentViewPlaceholder.frame = calculateRightOffscreenContentViewPlaceholderFrame()
        updateContentViewScales()
    }


    /// Scrolls to the page at the given index.
    ///
    /// - Parameters:
    ///   - index: The index of the target page to scroll.
    ///   - animated: A flag describing if the scroll should be performed with animations.
    public func scrollToPage(atIndex index: Int, animated: Bool = true) {
        let contentOffset = CGPoint(
            x: CGFloat(index + 1) * bounds.width,
            y: scrollView.contentOffset.y
        )
        scrollView.setContentOffset(contentOffset, animated: animated)
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard isScrollViewDidScrollObservationEnabled else { return }

        let contentSize = scrollView.contentSize.width - bounds.width * 2
        let contentOffset = scrollView.contentOffset.x - bounds.width
        let newContentViewIndex = bounds.width > 0 ? modIndex((Int(round(contentOffset / bounds.width))), model.pages.count) : 0
        if contentViewIndex != newContentViewIndex {
            contentViewIndex = newContentViewIndex
            model.onPageIndexChanged(contentViewIndex)
        }

        isScrollViewDidScrollObservationEnabled = false
        defer { isScrollViewDidScrollObservationEnabled = true }

        if contentOffset < -bounds.width {
            scrollView.contentOffset = CGPoint(
                x: scrollView.contentOffset.x + (scrollView.contentSize.width - bounds.width * 2),
                y: scrollView.contentOffset.y
            )
        }

        if contentOffset >= contentSize {
            scrollView.contentOffset = CGPoint(
                x: scrollView.contentOffset.x - (scrollView.contentSize.width - bounds.width * 2),
                y: scrollView.contentOffset.y
            )
        }

        updateContentViewScales()
    }

    private func updateContentViewScales() {
        let initialFrame = bounds
        allContentViews.enumerated().forEach { index, view in
            let containerFrame = initialFrame.offsetBy(
                dx: CGFloat(index) * initialFrame.width,
                dy: 0
            )
            let distanceFactor = min(1, abs(containerFrame.origin.x - scrollView.contentOffset.x) / bounds.width)
            let distanceScaleFactor = 1.0 + (model.neighboringPageScaleFactor - 1.0) * distanceFactor
            let distanceInset = UIEdgeInsets(
                top: model.pageInset.top + (model.neighboringPageInset.top - model.pageInset.top) * distanceFactor,
                left: model.pageInset.left + (model.neighboringPageInset.left - model.pageInset.left) * distanceFactor,
                bottom: model.pageInset.bottom + (model.neighboringPageInset.bottom - model.pageInset.bottom) * distanceFactor,
                right: model.pageInset.right + (model.neighboringPageInset.right - model.pageInset.right) * distanceFactor
            )

            view.transform = CGAffineTransform(scaleX: distanceScaleFactor, y: distanceScaleFactor)
            view.frame = CGRect(
                x: containerFrame.origin.x + distanceInset.left,
                y: containerFrame.origin.y + distanceInset.top,
                width: containerFrame.size.width - distanceInset.left - distanceInset.right,
                height: containerFrame.size.height - distanceInset.top - distanceInset.bottom
            )
        }
    }

    private func calculateLeftOffscreenContentViewPlaceholderFrame() -> CGRect {
        var rect = bounds.offsetBy(dx: -bounds.width, dy: 0)
        rect = CGRect(
            x: rect.origin.x + model.neighboringPageInset.left,
            y: rect.origin.y + model.neighboringPageInset.top,
            width: rect.size.width - model.neighboringPageInset.left - model.neighboringPageInset.right,
            height: rect.size.height - model.neighboringPageInset.top - model.neighboringPageInset.bottom
        )
        return rect
    }

    private func calculateRightOffscreenContentViewPlaceholderFrame() -> CGRect {
        var rect = bounds.offsetBy(dx: bounds.width * CGFloat(model.pages.count + 2), dy: 0)
        rect = CGRect(
            x: rect.origin.x + model.neighboringPageInset.left,
            y: rect.origin.y + model.neighboringPageInset.top,
            width: rect.size.width - model.neighboringPageInset.left - model.neighboringPageInset.right,
            height: rect.size.height - model.neighboringPageInset.top - model.neighboringPageInset.bottom
        )
        return rect
    }

    private func modIndex(_ lhs: Int, _ rhs: Int) -> Int {
        guard rhs > 0 else { return 0 }

        return (lhs % rhs + rhs) % rhs
    }
}
