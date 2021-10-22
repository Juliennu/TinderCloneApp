//
//  TopControlView.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/22.
//

import UIKit

class TopControlView: UIView {
    
    let tinderButton = createTopButton(imageName: "fire")
    let goodButton = createTopButton(imageName: "diamond")
    let messageButton = createTopButton(imageName: "message")
    let profileButton = createTopButton(imageName: "profile")
    
    //override init(frame: CGRect)の範囲外で関数を作るときは`static`をつける必要あり
    static private func createTopButton(imageName: String) -> UIButton {
        let button = UIButton(type: .custom)
        let image = UIImage(named: imageName)
        button.setImage(image, for: .normal)
        //画像の縦横比を維持する
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpStackView() {
        
        let baseStackView = UIStackView(arrangedSubviews: [tinderButton,goodButton, messageButton, profileButton])
        let space: CGFloat = 40
        
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
    }
}

