//  Copyright © 2020 Jamit Labs GmbH. All rights reserved.

import UIKit

final class CollapsibleItemView: UIView {
    
    init(backgroundColor: UIColor, height: CGFloat) {
        super.init(frame: .zero)

        self.backgroundColor = backgroundColor
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
