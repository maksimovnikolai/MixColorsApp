//
//  MixColorViewController.swift
//  MixColors
//
//  Created by Nikolai Maksimov on 09.02.2024.
//

import UIKit

final class MixColorViewController: UIViewController {
    
    // MARK: Private Properties
    private lazy var firstColorTitleLabel: UILabel = .makeLabel(withTitle: "Blue".localized())
    private lazy var firstColorButton: UIButton = .makeButton(.blue)
    
    private lazy var secondColorTitleLabel: UILabel = .makeLabel(withTitle: "Red".localized())
    private lazy var secondColorButton: UIButton = .makeButton(.red)
    
    private lazy var resultLabel: UILabel = .makeLabel(withTitle: "Purple".localized())
    private lazy var resultColorView: UIView = .makeView()
    
    private lazy var plusLabel: UILabel = .makeLabel(withTitle: "+", size: 40)
    private lazy var equalLabel: UILabel = .makeLabel(withTitle: "=", size: 40)

    
    private let mainStackView = UIStackView()
    
    private var top: CGFloat = 20
    private var leading: CGFloat = 60
    private var trailing: CGFloat = -60
    private var bottom: CGFloat = -20
    
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
        setupStackViews()
        settingsStacksDependingDevicePosition()
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
    
    private func setupStackViews() {
        
        // First Stack
        let firstColorStack: UIStackView = .makeVerticalStackView(firstColorTitleLabel, firstColorButton)
        
        // Second Stack
        let secondColorStack: UIStackView = .makeVerticalStackView(secondColorTitleLabel, secondColorButton)
        
        // Result Stack View
        let resultStackView: UIStackView = .makeVerticalStackView(resultLabel, resultColorView)

        
        // Setup Main StackView
        [firstColorStack, plusLabel, secondColorStack, equalLabel, resultStackView].forEach {
            mainStackView.addArrangedSubview($0)
            
            view.addSubview(mainStackView)
            mainStackView.translatesAutoresizingMaskIntoConstraints = false
            setupMainStackViewConstraints(top: top, leading: leading, trailing: trailing, bottom: bottom)
        }
    }
    
    // Check Device orientation
    private func settingsStacksDependingDevicePosition() {
        
        if UIDevice.current.orientation.isLandscape {
            mainStackView.axis = .horizontal
            mainStackView.alignment = .center
            mainStackView.distribution = .equalCentering
            
            top = 0
            leading = 60
            trailing = -60
            bottom = 0
            
        } else if UIDevice.current.orientation.isPortrait {
            
            mainStackView.axis = .vertical
            mainStackView.alignment = .center
            mainStackView.distribution = .equalSpacing
            
            top = 30
            leading = 30
            trailing = -30
            bottom = -30
        }
    }
}

// MARK: - Setup Main Stack View
extension MixColorViewController {
    
    private func setupMainStackViewConstraints(top: CGFloat, leading: CGFloat, trailing: CGFloat, bottom: CGFloat) {
        mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: bottom).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing).isActive = true
    }
}
