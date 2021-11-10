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
        
        nameLabel.text = "Juri, 26"
        
        
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
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension ProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = infoCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! InfoCollectionViewCell
        
        return cell
    }
}

// TODO: 別ファイルに分ける
class InfoCollectionViewCell: UICollectionViewCell {
    
    let nameLabel = ProfileLabel(title: "名前")
    let ageLabel = ProfileLabel(title: "年齢")
    let emailLabel = ProfileLabel(title: "email")
    let residenceLabel = ProfileLabel(title: "居住地")
    let hobbyLabel = ProfileLabel(title: "趣味")
    let introductonLabel = ProfileLabel(title: "自己紹介")
    
    let nameTextField = ProfileTextField(placeholder: "名前")
    let ageTextField = ProfileTextField(placeholder: "年齢")
    let emailTextField = ProfileTextField(placeholder: "email")
    let residenceTextField = ProfileTextField(placeholder: "居住地")
    let hobbyTextField = ProfileTextField(placeholder: "趣味")
    let introductionTextField = ProfileTextField(placeholder: "自己紹介")
    
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUpLayout()
    }
    
    private func setUpLayout() {
        
        let views =
        [
            [nameLabel, nameTextField],
            [ageLabel, ageTextField],
            [emailLabel, emailTextField],
            [residenceLabel, residenceTextField],
            [hobbyLabel, hobbyTextField],
            [introductonLabel, introductionTextField],
        
        ]
        
        //同様のViewをまとめて設定
        let stackViews = views.map { (views) -> UIStackView in
            guard let label = views.first as? UILabel,
                  let textField = views.last as? UITextField else { return UIStackView() }//値を正しく取得できないときは空のUIStackViewを返す
            
            let stackView = UIStackView(arrangedSubviews: [label, textField])
            stackView.axis = .vertical
            stackView.spacing = 5
            textField.anchor(height: 50)
            
            return stackView
        }
        
        let baseStackView = UIStackView(arrangedSubviews: stackViews)
        baseStackView.axis = .vertical
        baseStackView.spacing = 15
        addSubview(baseStackView)
        //cell内のviewの大きさを変えることで自動的にcellの大きさが変わってくれる
        nameTextField.anchor(width: UIScreen.main.bounds.width - 40, height: 80)
        baseStackView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 10, leftPadding: 20, rightPadding: 20)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
