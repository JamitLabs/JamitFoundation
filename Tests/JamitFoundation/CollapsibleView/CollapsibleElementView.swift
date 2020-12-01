//
//  File.swift
//  
//
//  Created by David Laubenstein on 25.11.20.
//

import Foundation
import UIKit

class CollapsibleElementView: UIView {
    init(backgroundColor: UIColor, height: CGFloat) {
        super.init(frame: .zero)

        self.backgroundColor = backgroundColor
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) hast not been implemented")
    }
}
