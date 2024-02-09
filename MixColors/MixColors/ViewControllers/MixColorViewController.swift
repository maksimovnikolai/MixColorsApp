//
//  MixColorViewController.swift
//  MixColors
//
//  Created by Nikolai Maksimov on 09.02.2024.
//

import UIKit

final class MixColorViewController: UIViewController {

    // MARK: Private Properties
    private lazy var firstColorTitleLabel: UILabel = makeLabel(withTitle: "Blue")
    private lazy var firstColorButton = makeButton(.blue)
    
    private lazy var secondColorTitleLabel: UILabel = makeLabel(withTitle: "Red")
    private lazy var secondColorButton = makeButton(.red)
    
    private lazy var resultLabel: UILabel = makeLabel(withTitle: "Result")
    private lazy var resultColorView: UIView = makeView()
    
    private lazy var plusLabel: UILabel = makeLabel(withTitle: "+", size: 40)
    private lazy var equalLabel: UILabel = makeLabel(withTitle: "=", size: 40)
    
    private let buttonsStackView = UIStackView()
    private let resultStackView = UIStackView()
    private let mainStackView = UIStackView()
    
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

// MARK: UI Configuration
extension MixColorViewController {
    
    private func configureNavBar() {
        navigationItem.title = "Mix Colors"
        view.backgroundColor = .systemBackground
    }
    
    private func configureButtonsStackView() {
        let leftVertStackView = UIStackView()
        leftVertStackView.axis = .vertical
        leftVertStackView.spacing = 5
        leftVertStackView.alignment = .center
        leftVertStackView.distribution = .fill
        [firstColorTitleLabel, firstColorButton].forEach {
            leftVertStackView.addArrangedSubview($0)
        }
        
        let rightVertStackView = UIStackView()
        rightVertStackView.axis = .vertical
        rightVertStackView.spacing = 5
        rightVertStackView.alignment = .center
        rightVertStackView.distribution = .fill
        [secondColorTitleLabel, secondColorButton].forEach { rightVertStackView.addArrangedSubview($0)
        }
        
        buttonsStackView.spacing = 40
        buttonsStackView.alignment = .fill
        buttonsStackView.distribution = .fill
        buttonsStackView.contentMode = .scaleToFill
        [leftVertStackView, plusLabel, rightVertStackView].forEach { buttonsStackView.addArrangedSubview($0) }
    }
    
    private func configureResultStackView() {
        resultStackView.axis = .vertical
        resultStackView.spacing = 5
        resultStackView.alignment = .center
        resultStackView.distribution = .fill
        [resultLabel, resultColorView].forEach { resultStackView.addArrangedSubview($0) }
    }
    
    private func configureMAinStackView() {
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
        [buttonsStackView, equalLabel, resultStackView].forEach {
            mainStackView.addArrangedSubview($0)
        }
    }
}


// MARK: - User Interface Design Methods
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

