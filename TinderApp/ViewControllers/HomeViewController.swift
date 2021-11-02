//
//  ViewController.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import PKHUD
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    //ログインユーザー
    private var user: User?
    //ログイン者以外のユーザー
    private var users = [User]()
    
    let topControlView = TopControlView()
    let cardView = UIView()//CardView()
    let bottomControlView = BottomControlView()
    
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ログアウト", for: .normal)
        return button
    }()
    
    // MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()
        setUpBindings()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        //ログインユーザーの情報を取得する
        Firestore.fetchUserFromFirestore(uid: uid) { user in
            if let user = user {
                self.user = user
            }
        }
        fetchUsers()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkUserAuth()
    }
    
    
    // MARK: Methods
    
    private func fetchUsers() {
        HUD.show(.progress)
        Firestore.fetchUserFromFirestore { users in
            HUD.hide()
            self.users = users
            print("ユーザー情報の取得に成功")
            
            //取得したユーザーごとにカードビューを生成
            self.users.forEach { (user) in
                let card = CardView(user: user)
                self.cardView.addSubview(card)
                card.anchor(top: self.cardView.topAnchor, bottom: self.cardView.bottomAnchor, left: self.cardView.leftAnchor, right: self.cardView.rightAnchor)
            }
        }
    }

    private func checkUserAuth() {
        //ログインユーザーがいない場合
        if Auth.auth().currentUser?.uid == nil {
            transitionToRegistrationVC()
        }
    }
    

    
    private func setUpLayout() {
        
        view.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [topControlView, cardView, bottomControlView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //垂直揃え
        stackView.axis = .vertical
        
        self.view.addSubview(stackView)
        self.view.addSubview(logoutButton)
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
        
        logoutButton.anchor(bottom: view.bottomAnchor, left: view.leftAnchor, bottomPadding: 20, leftPadding: 20)
    }
    
    private func transitionToRegistrationVC() {
        //レイアウトが完成してから処理を行うようタイミングを調整する
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            //画面遷移
            let registerViewController = RegisterViewController()
            //navigationControllerを設定
            let nav = UINavigationController(rootViewController: registerViewController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
    }
    
    private func setUpBindings() {
        
        topControlView.profileButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                let profileVC = ProfileViewController()
                self?.present(profileVC, animated: true)
            }
            .disposed(by: disposeBag)

    }
}


