//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import JamitFoundation
import UIKit

final class TableViewItemView: StatefulView<TableViewItemViewModel> {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var backgroundView: UIView!
    @IBOutlet private var imageViewContainer: UIView!
    @IBOutlet private var titleLabel: UILabel!
    
    private lazy var imageView: ImageView = {
        let imageView = ImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOpacity = 0.2
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 10)
        backgroundView.layer.shadowRadius = 10

        contentView.layer.cornerRadius = 10.0

        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageViewContainer.addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: imageViewContainer.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: imageViewContainer.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: imageViewContainer.bottomAnchor).isActive = true
    }

    override func didChangeModel() {
        super.didChangeModel()
        
        if let imageURL = model.imageURL {
            imageView.model = .url(imageURL)
        } else {
            imageView.model = .default
        }

        titleLabel.text = model.description
    }
}
