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
    
    override func viewWillLayoutSubviews() {
        mainStackView.spacing = UIDevice.current.orientation.isLandscape ? 20 : 80
    }
}

// MARK: - Common Init
extension MixColorViewController {
    
    private func commonInit() {
        configureNavBar()
        configureButtonsStackView()
        configureResultStackView()
        configureMAinStackView()
        setupMainStackViewConstraints()
        addTargets()
        setResultViewColor()
    }
}

// MARK: Project logic
extension MixColorViewController {
    private func addTargets() {
        firstColorButton.addTarget(self, action: #selector(setNewColorToFirstButton), for: .touchUpInside)
        secondColorButton.addTarget(self, action: #selector(setNewColorToSecondButton), for: .touchUpInside)
    }
    
    @objc
    private func setNewColorToFirstButton() {
        createColorPickerView(tag: 0)
    }
    
    @objc
    private func setNewColorToSecondButton() {
        createColorPickerView(tag: 1)
        
    }
    
    private func createColorPickerView(tag: Int) {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        picker.view.tag = tag
        present(picker, animated: true)
    }
    
    
    private func changeLeftButtonColor(color: UIColor) {
        firstColorButton.configuration?.baseBackgroundColor = color
    }
    
     private func addingColors(_ color1: UIColor, with color2: UIColor) -> UIColor {
        var (r1, g1, b1, a1) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
        var (r2, g2, b2, a2) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
        
        color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        return UIColor(red: min(r1 + r2, 1), green: min(g1 + g2, 1), blue: min(b1 + b2, 1), alpha: (a1 + a2) / 2)
    }
    
    private func setResultViewColor() {
        let newColor = addingColors(firstColorButton.configuration?.baseBackgroundColor ?? .white, with: secondColorButton.configuration?.baseBackgroundColor ?? .black)
        resultColorView.backgroundColor = newColor
        resultLabel.text = newColor.accessibilityName.capitalized
    }
}

// MARK: - UIColorPickerViewControllerDelegate
extension MixColorViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        
        if viewController.view.tag == 0 {
            firstColorButton.configuration?.baseBackgroundColor = color
            firstColorTitleLabel.text = color.accessibilityName.capitalized
            setResultViewColor()
        } else if viewController.view.tag == 1 {
            secondColorButton.configuration?.baseBackgroundColor = color
            secondColorTitleLabel.text = color.accessibilityName.capitalized
            setResultViewColor()
        }
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
        [secondColorTitleLabel, secondColorButton].forEach {
            rightVertStackView.addArrangedSubview($0)
        }
        
        buttonsStackView.spacing = 40
        buttonsStackView.alignment = .fill
        buttonsStackView.distribution = .fill
        buttonsStackView.contentMode = .scaleToFill
        [leftVertStackView, plusLabel, rightVertStackView].forEach {
            buttonsStackView.addArrangedSubview($0)
        }
    }
    
    private func configureResultStackView() {
        resultStackView.axis = .vertical
        resultStackView.spacing = 5
        resultStackView.alignment = .center
        resultStackView.distribution = .fill
        [resultLabel, resultColorView].forEach {
            resultStackView.addArrangedSubview($0)
        }
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

// MARK: - Setup Main Stack View
extension MixColorViewController {
    
    private func setupMainStackViewConstraints() {
        view.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
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
        view.layer.cornerRadius = 5
        view.backgroundColor = .yellow
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return view
    }
}
