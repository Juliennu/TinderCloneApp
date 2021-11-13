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
    
    // MARK: Properties
    private let disposeBag = DisposeBag()
    //ログインユーザー
    private var user: User?
    //ログイン者以外のユーザー
    private var users = [User]()
    
    // MARK: UIViews
    let topControlView = TopControlView()
    let cardView = UIView()//CardView()
    let bottomControlView = BottomControlView()
    
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
        Firestore.fetchUserFromFirestore(uid: uid) { (user) in
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
        
        //情報を空にする
        self.users = []
        
        Firestore.fetchUserFromFirestore { users in
            HUD.hide()
            self.users = users
            print("自分以外のユーザー情報の取得に成功")
            
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
    
    private func transitionToRegistrationVC() {
            //画面遷移
            let registerViewController = RegisterViewController()
            //navigationControllerを設定
            let nav = UINavigationController(rootViewController: registerViewController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
    }
    
    private func setUpBindings() {
        
        topControlView.profileButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                let profileVC = ProfileViewController()
                //ProfielVCにユーザー情報を渡す
                profileVC.user = self?.user
                //delegateを設定（モーダル遷移したprofileVCを閉じた後の処理を設定するため）
                profileVC.presentationController?.delegate = self
                self?.present(profileVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        
            bottomControlView.reloadView.button?.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.fetchUsers()
            }
            .disposed(by: disposeBag)
    }
    
}

// MARK: - UIAdaptivePresentationControllerDelegate
extension HomeViewController: UIAdaptivePresentationControllerDelegate {
    
    //presentで遷移したVCがdismissされたときに呼ばれる
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        if Auth.auth().currentUser == nil {
            //情報を空にしておく
            self.user = nil
            self.users = []
            
            transitionToRegistrationVC()
        }
    }
}
