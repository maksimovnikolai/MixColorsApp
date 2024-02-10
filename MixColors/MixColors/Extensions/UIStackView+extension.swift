//
//  UIStackView+extension.swift
//  MixColors
//
//  Created by Nikolai Maksimov on 11.02.2024.
//

import UIKit

extension UIStackView {
    
    static func makeVerticalStackView(_ arrangedSubViews: UIView...) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        arrangedSubViews.forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }
}
