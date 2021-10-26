//
//  LoginViewController.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/26.
//
import UIKit
import FirebaseAuth
import RxSwift

class LoginViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    //MARK: UIViews
    private let titleLabel = RegisterTitleLabel(text: "Login")
    private let emailTextField = RegisterTextField(placeholderText: "email", keyboardType: .emailAddress)
    private let passwordTextField = RegisterTextField(placeholderText: "password", keyboardType: .emailAddress)
    private let loginButton = RegisterButton(title: "ログイン")
    private let dontHaveAccountButton = UIButton(type: .system).creatAboutAccountButton(title: "アカウント作成はこちら")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.isSecureTextEntry = true
        
        setUpGradientLayer()
        setUpLayout()
        setUpBindings()
    }
    
    private func setUpBindings() {
        
        //textFieldのバインディング
        
        emailTextField.rx.text
            .asDriver()
            .drive() { [weak self] text in
//                self?.viewModel.emailTextInput.onNext(text ?? "")
                //textの情報ハンドル
            
        }
        .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .asDriver()
            .drive() { [weak self] text in
//                self?.viewModel.passwordTextInput.onNext(text ?? "")
                //textの情報ハンドル
            
        }
        .disposed(by: disposeBag)
        
        //Buttonのバインディング
        loginButton.rx.tap
            .asDriver()
            .drive() { [weak self] _ in
                self?.loginUser()
                
            }
            .disposed(by: disposeBag)
        
        dontHaveAccountButton.rx.tap
            .asDriver()
            .drive() { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)//.popToRootViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        //viewModelのバインディング
//        viewModel.validRegisterDriver
//            .drive { validAll in
//                self.registerButton.isEnabled = validAll//true or falseが入る
//                self.registerButton.backgroundColor = validAll ? Colors.pinkColor : Colors.invalidButtonColor
//            }
//            .disposed(by: disposeBag)

    }
    
    
    private func loginUser() {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            if let err = err {
                print("ログインに失敗: ", err)
                return
            }
            self.dismiss(animated: true)
            print("ログインに成功")
        }
    }
    
    private func setUpGradientLayer() {
        let layer = CAGradientLayer()
        layer.colors = [Colors.orangeColor.cgColor, Colors.pinkColor.cgColor]
        layer.locations = [0.0, 1.3]
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
    }
    
    private func setUpLayout() {
        
        let baseStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, dontHaveAccountButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        
        view.addSubview(titleLabel)
        view.addSubview(baseStackView)
        
        
        titleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor, height: 90, bottomPadding: 20)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 40, rightPadding: 40)
        emailTextField.anchor(height: 45)
        
    }
}
