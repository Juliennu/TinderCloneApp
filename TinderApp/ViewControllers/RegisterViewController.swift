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
        
        nameTextField.rx.text
            .asDriver()
            .drive() { [weak self] text in
                //textの情報ハンドル
            
        }
        .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .asDriver()
            .drive() { [weak self] text in
                //textの情報ハンドル
            
        }
        .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .asDriver()
            .drive() { [weak self] text in
                //textの情報ハンドル
            
        }
        .disposed(by: disposeBag)
        
        registerButton.rx.tap
            .asDriver()
            .drive() { [weak self] _ in
                self?.createUserToFireAuth()
                
            }
            .disposed(by: disposeBag)
    }
    
    private func createUserToFireAuth() {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (auth, err) in
            if let err = err {
                print("auth情報の保存に失敗: ", err)
                return
            }
            
            guard let uid = auth?.user.uid else { return }
            self.setUserDataToFirestore(email: email, uid: uid)
        }
    }
    
    private func setUserDataToFirestore(email: String, uid: String) {
        
        guard let name = nameTextField.text else { return }
        
        let document: [String: Any] = [
            "name": name,
            "email": email,
            "createdAt": Timestamp()
        ]
        
        
        Firestore.firestore().collection("users").document(uid).setData(document) { err in
            if let err = err {
                print("ユーザー情報のfirestoreへの保存に失敗: ", err)
                return
            }
            
            print("ユーザー情報のfirestoreへの保存に成功")
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
