//
//  CardView.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/22.
//

import UIKit

class CardView: UIView {
    //グラデーションをつける
    private let gradientLayer = CAGradientLayer()
    
    //MARK: UIViews
    private let cardImageView = CardImageView()
    
    private let infoButton = UIButton(type: .system).createCardInfoButton()
    
    private let nameLabel = CardInfoLabel(text: "Juri, 26", font: .systemFont(ofSize: 40, weight: .heavy))
    
    private let residenceLabel = CardInfoLabel(text: "日本、栃木", font: .systemFont(ofSize: 18, weight: .regular))
    
    private let hobbyLabel = CardInfoLabel(text: "ボードゲーム", font: .systemFont(ofSize: 20, weight: .regular))
    
    private let introductionLabel = CardInfoLabel(text: "土日に一緒に遊べる友達を探しています", font: .systemFont(ofSize: 18, weight: .regular))
    
    private let goodLabel = CardInfoLabel(text: "GOOD", color: Colors.greenColor)
    
    private let nopeLabel = CardInfoLabel(text: "NOPE", color: Colors.redColor)

    init(user: User) {
        super.init(frame: .zero)
        
        setUpLayout(user: user)
        setUpGradientLayer()
        
        //左右への動きを認識するジェスチャーを設定
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCardView))
        self.addGestureRecognizer(panGesture)

    }
    
    override func layoutSubviews() {
        //Viewが作成されたタイミングで大きさを指定する
        gradientLayer.frame = self.bounds
    }
    
    private func setUpGradientLayer() {
        //指定した色を混ぜる
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        //位置の調整
        gradientLayer.locations = [0.3, 1.1]
        cardImageView.layer.addSublayer(gradientLayer)
        
    }
    
    @objc private func panCardView(gesture: UIPanGestureRecognizer) {

        let translation = gesture.translation(in: self)
        guard let view = gesture.view else { return }
        
        //動かしている時の動き
        if gesture.state == .changed {
            handlePanChenge(translation: translation)

        //手を離した時の動き
        } else if gesture.state == .ended {
            handlePanEnded(view: view, translation: translation)
        }
    }
    
    private func handlePanChenge(translation: CGPoint) {
        let degree: CGFloat = translation.x / 20
        //回転する動きをつける
        let angle = degree * .pi / 100//pi = 3.14...の円周率
        let rotateTranslation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotateTranslation.translatedBy(x: translation.x, y: translation.y)
        
        //動きに合わせてLabelのalphaを変更する
        //alpha値の最大値1を100分割して細かい設定をする
        let ratio: CGFloat = 1 / 100//Max値を100にする
        let ratioValue = ratio * translation.x
        
        if translation.x > 0 {
            self.goodLabel.alpha = ratioValue
        } else if translation.x < 0 {
            self.nopeLabel.alpha = -ratioValue
        }
//        print("translation.x: ", translation.x)
    }
    
    private func handlePanEnded(view: UIView, translation: CGPoint) {
        //NOPEの時
        if translation.x < -120 {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {
                
                let degree: CGFloat = -600 / 40
                let angle = degree * .pi / 180
                
                let rotateTranslation = CGAffineTransform(rotationAngle: angle)
                view.transform = rotateTranslation.translatedBy(x: -600, y: 100)
                self.layoutIfNeeded()
                
            } completion: { _ in
                self.removeFromSuperview()
            }
        }
        // GOODの時
        else if translation.x > 120 {
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {
                
                let degree: CGFloat = 600 / 40
                let angle = degree * .pi / 180
                
                let rotateTranslation = CGAffineTransform(rotationAngle: angle)
                view.transform = rotateTranslation.translatedBy(x: 600, y: 100)
                self.layoutIfNeeded()
                
            } completion: { _ in
                self.removeFromSuperview()
            }
            
        } else {
            //いろんな動き(バウンドなど)をつけられる
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {
                //transformを元に戻す
                self.transform = .identity
                //アニメーションを認識させる
                self.layoutIfNeeded()
                
                self.goodLabel.alpha = 0
                self.nopeLabel.alpha = 0
            }
        }
    }
                                                
                                                
    
    private func setUpLayout(user: User) {
        
        let infoVerticalStackView = UIStackView(arrangedSubviews: [residenceLabel, hobbyLabel, introductionLabel])
        infoVerticalStackView.axis = .vertical

        
        let baseStackView = UIStackView(arrangedSubviews: [infoVerticalStackView, infoButton])
        baseStackView.axis = .horizontal
        // Viewの配置を作成
        addSubview(cardImageView)
        addSubview(nameLabel)
        addSubview(baseStackView)
        addSubview(goodLabel)
        addSubview(nopeLabel)

        cardImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 10, rightPadding: 10)
        baseStackView.anchor(bottom: cardImageView.bottomAnchor, left: cardImageView.leftAnchor, right: cardImageView.rightAnchor, bottomPadding: 20, leftPadding: 20, rightPadding: 20)
        infoButton.anchor(width: 40)
        nameLabel.anchor(bottom: baseStackView.topAnchor, left: cardImageView.leftAnchor, bottomPadding: 10, leftPadding: 20)
        goodLabel.anchor(top: cardImageView.topAnchor, left: cardImageView.leftAnchor, width: 140, height: 55, topPadding: 25, leftPadding: 25)
        nopeLabel.anchor(top: cardImageView.topAnchor, right: cardImageView.rightAnchor, width: 140, height: 55, topPadding: 25, rightPadding: 25)
        
        //ユーザー情報をViewに反映
        nameLabel.text = user.name
        introductionLabel.text = user.email

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
