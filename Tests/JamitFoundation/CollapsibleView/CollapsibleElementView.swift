//
//  File.swift
//  
//
//  Created by David Laubenstein on 25.11.20.
//

import Foundation
import UIKit

class CollapsibleElementView: UIView {
    private lazy var textView: UITextField = {
        let textView = UITextField()
        return textView
    }()


    init(backgroundColor: UIColor, height: CGFloat, text: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true

        addSubview(textView)
        textView.text = text

        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.heightAnchor.constraint(equalToConstant: height).isActive = true
        textView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) hast not been implemented")
    }
}
