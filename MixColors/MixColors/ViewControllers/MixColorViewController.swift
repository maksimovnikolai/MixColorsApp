//
//  MixColorViewController.swift
//  MixColors
//
//  Created by Nikolai Maksimov on 09.02.2024.
//

import UIKit

class MixColorViewController: UIViewController {

    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }


}

// MARK: - Common Init
extension MixColorViewController {
    
    private func commonInit() {
     
        
    }
}

// MARK: Make UI-element
extension MixColorViewController {
    
    private func makeButton(_ backgroundColor: UIColor) -> UIButton {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.baseBackgroundColor = backgroundColor
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return button
    }
    
    private func makeLabel(withTitle title: String? = nil, size: CGFloat? = nil) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = .boldSystemFont(ofSize: size ?? 16)
        label.textAlignment = .center
        return label
    }
    
    private func makeView() -> UIView {
        let view = UIView()
        view.backgroundColor = .yellow
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return view
    }
}

