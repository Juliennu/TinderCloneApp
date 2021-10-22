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
        imageView.backgroundColor = .blue
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .brown
        addSubview(cardImageView)
        addSubview(nameLabel)
        cardImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 10, rightPadding: 10)
        nameLabel.anchor(bottom: cardImageView.bottomAnchor, left: cardImageView.leftAnchor, bottomPadding: 40, leftPadding: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
