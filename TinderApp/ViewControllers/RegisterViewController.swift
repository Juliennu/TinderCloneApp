//
//  RegisterViewController.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/25.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private let titleLabel = RegisterTitleLabel()

    private let nameTextField = RegisterTextField(placeholderText: "Name")
    
    private let emailTextField = RegisterTextField(placeholderText: "email")
    
    private let passwordTextField = RegisterTextField(placeholderText: "password")
    
    private let registerButton = RegisterButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpGradientLayer()
        setUpLayout()
    }
    
    private func setUpGradientLayer() {
        let layer = CAGradientLayer()
        layer.colors = [Colors.pinkColor.cgColor, Colors.orangeColor.cgColor]
        layer.locations = [0.0, 1.3]
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
    }
    
    private func setUpLayout() {
        let baseStackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, registerButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        
        view.addSubview(titleLabel)
        view.addSubview(baseStackView)
        
        
        titleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor, height: 80, bottomPadding: 20)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 40, rightPadding: 40)
        nameTextField.anchor(height: 45)
        
    }
    
}
