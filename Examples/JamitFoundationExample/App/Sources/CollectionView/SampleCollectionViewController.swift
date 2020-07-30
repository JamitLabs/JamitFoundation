//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

class SampleCollectionViewController: StatefulViewController<SampleCollectionViewViewModel> {
    enum Constants {
        static let itemSize: CGSize = CGSize(width: 44, height: 44)
        static let supplementaryHeight: CGFloat = 120
    }

    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var collectionViewFlowLayout: UICollectionViewFlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = String(describing: type(of: self))
        configureCollectionView()
    }

    private func configureCollectionView() {
        collectionViewFlowLayout.minimumLineSpacing = 8
        collectionViewFlowLayout.minimumInteritemSpacing = 8
        collectionView.contentInset = .init(top: 8, left: 8, bottom: 8, right: 8)

        collectionView.register(cellOfType: FancyLabelViewCell.self)
        collectionView.register(reusableHeaderWithType: FancyLabelSupplementaryView.self)
        collectionView.register(reusableFooterWithType: FancyLabelSupplementaryView.self)
    }
}

extension SampleCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cellOfType: FancyLabelViewCell.self, for: indexPath)
        cell.model = model.items[indexPath.item]
        return cell
    }
}

extension SampleCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return model.header == nil ? .zero : CGSize(width:collectionView.bounds.width , height: Constants.supplementaryHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return model.footer == nil ? .zero : CGSize(width:collectionView.bounds.width , height: Constants.supplementaryHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constants.itemSize
    }
}

extension SampleCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let supplementaryView = collectionView.dequeue(reusableViewType: FancyLabelSupplementaryView.self, ofKind: kind, for: indexPath)

        let supplementaryModel: FancyLabelViewModel?
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            supplementaryModel = model.header
            supplementaryView.contentInsets.bottom = 8

        case UICollectionView.elementKindSectionFooter:
            supplementaryModel = model.footer
            supplementaryView.contentInsets.top = 8

        default:
            supplementaryModel = nil
        }

        supplementaryModel.flatMap { supplementaryView.model = $0 }
        return supplementaryView
    }
}
