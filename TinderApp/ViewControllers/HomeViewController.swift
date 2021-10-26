//
//  ViewController.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()
        showRegistrationView()

    }
    
    private func setUpLayout() {
        
        view.backgroundColor = .white
        let topControlView = TopControlView()
        let cardView = CardView()
        let bottomControlView = BottomControlView()
        
        let stackView = UIStackView(arrangedSubviews: [topControlView, cardView, bottomControlView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //垂直揃え
        stackView.axis = .vertical
        
        self.view.addSubview(stackView)
        
        //StackViewのレイアウト
        [
            topControlView.heightAnchor.constraint(equalToConstant: 100),
            bottomControlView.heightAnchor.constraint(equalToConstant: 120),
            
            //safeAreaを除外する
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
            .forEach { $0.isActive = true }
    }
    
    private func showRegistrationView() {
        //レイアウトが完成してから処理を行うようタイミングを調整する
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            //画面遷移
            let registerViewController = RegisterViewController()
            registerViewController.modalPresentationStyle = .fullScreen
            self.present(registerViewController, animated: true)
        }
    }
}


