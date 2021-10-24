//
//  CardView.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/22.
//

import UIKit

class CardView: UIView {
    
    let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "dogAndBards")
        //イメージが境界に合わせて切り取られる
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let infoButton = UIButton(type: .system).createCardInfoButton()
    
    private let nameLabel = CardInfoLabel(labelText: "Juri, 26", labelFont: .systemFont(ofSize: 40, weight: .heavy))
    
    private let residenceLabel = CardInfoLabel(labelText: "日本、栃木", labelFont: .systemFont(ofSize: 18, weight: .regular))
    
    private let hobbyLabel = CardInfoLabel(labelText: "ボードゲーム", labelFont: .systemFont(ofSize: 20, weight: .regular))
    
    private let introductionLabel = CardInfoLabel(labelText: "土日に一緒に遊べる友達を探しています", labelFont: .systemFont(ofSize: 18, weight: .regular))
    
    private let goodLabel = CardInfoLabel(labelText: "GOOD", color: Colors.greenColor)
    
    private let nopeLabel = CardInfoLabel(labelText: "NOPE", color: Colors.redColor)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpLayout()
        
        //左右への動きを認識するジェスチャーを設定
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCardView))
        self.addGestureRecognizer(panGesture)

    }
    
    @objc private func panCardView(gesture: UIPanGestureRecognizer) {

        let translation = gesture.translation(in: self)
        
        //動かしている時の動き
        if gesture.state == .changed {
            handlePanChenge(translation: translation)

        //手を離した時の動き
        } else if gesture.state == .ended {
            handlePanEnded()
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
    
    private func handlePanEnded() {
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
                                                
                                                
    
    private func setUpLayout() {
        
        let infoVerticalStackView = UIStackView(arrangedSubviews: [residenceLabel, hobbyLabel, introductionLabel])
        infoVerticalStackView.axis = .vertical

        
        let baseStackView = UIStackView(arrangedSubviews: [infoVerticalStackView, infoButton])
        baseStackView.axis = .horizontal
        
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

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
