//
//  MixColorViewController.swift
//  MixColors
//
//  Created by Nikolai Maksimov on 09.02.2024.
//

import UIKit

final class MixColorViewController: UIViewController {
    
    // MARK: Private Properties
    private lazy var firstColorTitleLabel: UILabel = makeLabel(withTitle: "Blue".localized())
    private lazy var firstColorButton = makeButton(.blue)
    
    private lazy var secondColorTitleLabel: UILabel = makeLabel(withTitle: "Red".localized())
    private lazy var secondColorButton = makeButton(.red)
    
    private lazy var resultLabel: UILabel = makeLabel(withTitle: "Purple".localized())
    private lazy var resultColorView: UIView = makeView()
    
    private lazy var plusLabel: UILabel = makeLabel(withTitle: "+", size: 40)
    private lazy var equalLabel: UILabel = makeLabel(withTitle: "=", size: 40)
    
    private let buttonsStackView = UIStackView()
    private let resultStackView = UIStackView()
    private let mainStackView = UIStackView()
    
    private let device = UIDevice.current.orientation
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        settingsStacksDependingDevicePosition()
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
    
    private func settingsStacksDependingDevicePosition() {
       
        if device.isLandscape {
            mainStackView.axis = .horizontal
            mainStackView.alignment = .center
            mainStackView.distribution = .equalSpacing
            
            buttonsStackView.axis = .horizontal
            buttonsStackView.alignment = .center
            buttonsStackView.distribution = .equalSpacing
            buttonsStackView.spacing = 40
        } else {
            mainStackView.axis = .vertical
            buttonsStackView.axis = .vertical
            buttonsStackView.spacing = 30
        }

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
        let newColor = addingColors(firstColorButton.configuration?.baseBackgroundColor ?? .white,
                                    with: secondColorButton.configuration?.baseBackgroundColor ?? .black)
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
    
    private func stackViewConfigureHelper(_ arrangedSubViews: UIView...) -> UIStackView {
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
        
    // Buttons Stack Configure
    private func configureButtonsStackView() {
        let firstColorStack = stackViewConfigureHelper(firstColorTitleLabel, firstColorButton)
        let secondColorStack = stackViewConfigureHelper(secondColorTitleLabel, secondColorButton)
        buttonsStackView.axis = device.isPortrait ? .vertical : .horizontal
        buttonsStackView.spacing = device.isPortrait ? 30 : 40
        buttonsStackView.alignment = device.isPortrait ? .fill : .center
        buttonsStackView.distribution = device.isPortrait ? .fillProportionally : .equalSpacing
        
        [firstColorStack, plusLabel, secondColorStack].forEach {
            buttonsStackView.addArrangedSubview($0)
        }
    }
    
    // Result Stack Configure
    private func configureResultStackView() {
        resultStackView.axis = .vertical
        resultStackView.spacing = 5
        resultStackView.alignment = .center
        resultStackView.distribution = .equalCentering
        [resultLabel, resultColorView].forEach {
            resultStackView.addArrangedSubview($0)
        }
    }

    // Main Stack Configure
    private func configureMAinStackView() {
        mainStackView.axis = UIDevice.current.orientation.isPortrait ? .vertical : .horizontal
        mainStackView.alignment = .center
        mainStackView.distribution = .equalSpacing
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
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
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
        label.numberOfLines = 0
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
