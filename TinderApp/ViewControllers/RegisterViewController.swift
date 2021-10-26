//
//  RegisterViewController.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/25.
//

import UIKit
import RxSwift
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = RegisterViewModel()
    
    //MARK: UIViews
    private let titleLabel = RegisterTitleLabel()

    private let nameTextField = RegisterTextField(placeholderText: "Name")
    
    private let emailTextField = RegisterTextField(placeholderText: "email", keyboardType: .emailAddress)
    
    private let passwordTextField = RegisterTextField(placeholderText: "password", keyboardType: .emailAddress)
    
    private let registerButton = RegisterButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.isSecureTextEntry = true
        
        setUpGradientLayer()
        setUpLayout()
        setUpBindings()
    }
    
    //MARK: Methods
    private func setUpBindings() {
        
        //textFieldのバインディング
        nameTextField.rx.text
            .asDriver()
            .drive() { [weak self] text in
                //ViewModelにデータを渡す
                self?.viewModel.nameTextInput.onNext(text ?? "")
                //textの情報ハンドル
            
        }
        .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .asDriver()
            .drive() { [weak self] text in
                self?.viewModel.emailTextInput.onNext(text ?? "")
                //textの情報ハンドル
            
        }
        .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .asDriver()
            .drive() { [weak self] text in
                self?.viewModel.passwordTextInput.onNext(text ?? "")
                //textの情報ハンドル
            
        }
        .disposed(by: disposeBag)
        
        registerButton.rx.tap
            .asDriver()
            .drive() { [weak self] _ in
                self?.createUser()
                
            }
            .disposed(by: disposeBag)
        
        //viewModelのバインディング
        viewModel.validRegisterDriver
            .drive { validAll in
                self.registerButton.isEnabled = validAll//true or falseが入る
                self.registerButton.backgroundColor = validAll ? Colors.pinkColor : Colors.invalidButtonColor
            }
            .disposed(by: disposeBag)

    }
    
    private func createUser() {
        let name = nameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        
        Auth.createUserToFireAuth(name: name, email: email, password: password) { success in
            if  success {
                print("処理が完了")
            }
        }
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
