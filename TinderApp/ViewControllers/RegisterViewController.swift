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
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
        setUpStackView()
    }
    
    private func setUpStackView() {
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
