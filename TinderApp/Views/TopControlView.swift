//
//  TopControlView.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/22.
//

import UIKit
import RxCocoa//UIの変化を受け取れる？
import RxSwift

class TopControlView: UIView {
    
    private let disposeBag = DisposeBag()
    
    let tinderButton = createTopButton(selectedImageName: "fire", unselectedImage: "fireUnselected")
    let goodButton = createTopButton(selectedImageName: "diamond", unselectedImage: "diamondUnselected")
    let messageButton = createTopButton(selectedImageName: "message", unselectedImage: "messageUnselected")
    let profileButton = createTopButton(selectedImageName: "profile", unselectedImage: "profileUnselected")
    
    //override init(frame: CGRect)の範囲外で関数を作るときは`static`をつける必要あり
    static private func createTopButton(selectedImageName: String, unselectedImage: String) -> UIButton {
        let button = UIButton(type: .custom)
        let selectedImage = UIImage(named: selectedImageName)
        let unselectedImage = UIImage(named: unselectedImage)
        //ボタン選択時のイメージ
        button.setImage(selectedImage, for: .selected)
        //ボタン未選択時のイメージ
        button.setImage(unselectedImage, for: .normal)
        //画像の縦横比を維持する
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpStackView()
        setUpBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpStackView() {
        
        let baseStackView = UIStackView(arrangedSubviews: [tinderButton,goodButton, messageButton, profileButton])
        let space: CGFloat = 43
        
        baseStackView.axis = .horizontal
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = space
        baseStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(baseStackView)
        
        [
            baseStackView.topAnchor.constraint(equalTo: topAnchor),
            baseStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            baseStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: space),
            baseStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -space),
        ]
            .forEach { $0.isActive = true }
        
        //初期でTinderButtonを選択状態にする
        tinderButton.isSelected = true
    }
    
    //ボタン選択時に色を変える処理
    private func setUpBindings() {
        //tap時の処理
        tinderButton.rx.tap
            //ドライバー：①mainスレッドで実行される②エラーを流さない
            .asDriver()
            .drive(onNext: { [weak self] _ in//循環参照防止のためweak selfにする
                guard let self = self else { return }
                self.handleSelectedButton(selectedButton: self.tinderButton)
            })
            //stream(キャッシュ？)を貯めておき、Viewが破棄される時に一緒に捨てるゴミだめのようなもの
            //これを書かないとずっと処理が続いてしまいメモリーリークになる
            .disposed(by: disposeBag)
        
        goodButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.handleSelectedButton(selectedButton: self.goodButton)
            })
            .disposed(by: disposeBag)
        
        messageButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.handleSelectedButton(selectedButton: self.messageButton)
            })
            .disposed(by: disposeBag)
        
        profileButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.handleSelectedButton(selectedButton: self.profileButton)
            })
            .disposed(by: disposeBag)
    }
    
    private func handleSelectedButton(selectedButton: UIButton) {
        let buttons = [tinderButton, goodButton, messageButton, profileButton]
        buttons.forEach { button in
            if button == selectedButton {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
    }
}

