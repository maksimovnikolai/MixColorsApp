//
//  UIView+extension.swift
//  MixColors
//
//  Created by Nikolai Maksimov on 11.02.2024.
//

import UIKit

extension UIView {
    
    static func makeView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return view
    }
}
