//
//  UILabel+extension.swift
//  MixColors
//
//  Created by Nikolai Maksimov on 11.02.2024.
//

import UIKit

extension UILabel {
    
    static func makeLabel(withTitle title: String? = nil, size: CGFloat? = nil) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = .boldSystemFont(ofSize: size ?? 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }
}
