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
        imageView.backgroundColor = .gray//.blue
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .heavy)//boldよりも濃い
        label.textColor = .white
        label.text = "Juri, 26"
        return label
    }()
    
    let infoButton: UIButton = {
        let button = UIButton(type: .system)
        let buttonImage = UIImage(systemName: "info.circle.fill")?
            //サイズ調整
            .resize(size: .init(width: 40, height: 40))
        button.setImage(buttonImage, for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let residenceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        label.text = "日本、栃木"
        return label
    }()
    
    let hobbyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.text = "ボードゲーム"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let introductionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        label.text = "土日に一緒に遊べる友達を探しています"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let goodLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 45)
        label.text = "GOOD"
        label.textColor = Colors.greenColor
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 3
        label.layer.borderColor = Colors.greenColor.cgColor
        label.textAlignment = .center
        return label
    }()
    
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
    }
    
    private func handlePanEnded() {
        //いろんな動き(バウンドなど)をつけられる
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {
            //transformを元に戻す
            self.transform = .identity
            //アニメーションを認識させる
            self.layoutIfNeeded()
        }
    }
                                                
                                                
    
    private func setUpLayout() {
        
        let infoVerticalStackView = UIStackView(arrangedSubviews: [residenceLabel, hobbyLabel, introductionLabel])
        infoVerticalStackView.axis = .vertical

        
        let baseStackView = UIStackView(arrangedSubviews: [infoVerticalStackView, infoButton])
        baseStackView.axis = .horizontal
        
        addSubview(cardImageView)
        addSubview(nameLabel)
        addSubview(goodLabel)
        addSubview(baseStackView)

        
        cardImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 10, rightPadding: 10)
        
        baseStackView.anchor(bottom: cardImageView.bottomAnchor, left: cardImageView.leftAnchor, right: cardImageView.rightAnchor, bottomPadding: 20, leftPadding: 20, rightPadding: 20)
        
        infoButton.anchor(width: 40)
        
        nameLabel.anchor(bottom: baseStackView.topAnchor, left: cardImageView.leftAnchor, bottomPadding: 10, leftPadding: 20)
        
        goodLabel.anchor(top: cardImageView.topAnchor, left: cardImageView.leftAnchor, width: 140, height: 55, topPadding: 25, leftPadding: 25)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
