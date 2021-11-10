//
//  ProfileViewController.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/11/02.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
    var user: User?
    private let cellId = "cellId"
    
    // MARK: UIViews
    let saveButton = UIButton(type: .system).createProfileTopButton(title: "保存")
    let logoutButton = UIButton(type: .system).createProfileTopButton(title: "ログアウト")
    let profileImageView = ProfileImageView()
    let nameLabel = ProfileLabel()
    let profileEditButton = UIButton(type: .system).createProfileEditButton()
    
    //lazy: collectionView.delegate = self など自分自身にアクセスするために必要。varにする(let不可)。
    lazy var infoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //collectionViewのセルのレイアウトなどをカスタム
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize//中のViewを元にして自動的に大きさが変化する動きをしてくれる
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        setUpLayout()
        logoutButton.addTarget(self, action: #selector(tappedLogoutButton), for: .touchUpInside)

    }
    
    @objc private func tappedLogoutButton() {
        
        do {
            try Auth.auth().signOut()
            transitionToRegistrationVC()
        } catch {
            print("ログアウトに失敗")
        }
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
    
    private func setUpLayout() {
        
        view.backgroundColor = .white

        //Viewの配置を設定
        view.addSubview(saveButton)
        view.addSubview(logoutButton)
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(profileEditButton)
        view.addSubview(infoCollectionView)
        
        saveButton.anchor(top: view.topAnchor, left: view.leftAnchor, topPadding: 20, leftPadding: 20)
        logoutButton.anchor(top: view.topAnchor, right: view.rightAnchor,topPadding: 20, rightPadding: 20)
        profileImageView.anchor(top: view.topAnchor, centerX: view.centerXAnchor, width: 180, height: 180, topPadding: 60)
        nameLabel.anchor(top: profileImageView.bottomAnchor, centerX: view.centerXAnchor, topPadding: 20)
        profileEditButton.anchor(top: profileImageView.topAnchor, right: profileImageView.rightAnchor, width: 60, height: 60)
        infoCollectionView.anchor(top: nameLabel.bottomAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, topPadding: 20)
        
        //ログインユーザー情報を反映
        nameLabel.text = user?.name ?? "匿名ユーザー"
        
        
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension ProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = infoCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! InfoCollectionViewCell
        //ログインユーザー情報を渡す
        cell.user = self.user
        return cell
    }
}

