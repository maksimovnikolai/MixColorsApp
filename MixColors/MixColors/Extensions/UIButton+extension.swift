//
//  UIButton+extension.swift
//  MixColors
//
//  Created by Nikolai Maksimov on 11.02.2024.
//

import UIKit

extension UIButton {
    
    static func makeButton(_ backgroundColor: UIColor) -> UIButton {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = backgroundColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return button
    }
}

