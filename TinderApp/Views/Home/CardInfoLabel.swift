//
//  CardInfoLabel.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/25.
//

import UIKit


class CardInfoLabel: UILabel {
    
    //独自で作成したinitializerなのでoverrideをつけない
    
    //good,nope Label
    init(text: String, color: UIColor) {//frameに初期値0を設定
        super.init(frame: .zero)
        
        font = .boldSystemFont(ofSize: 45)
        self.text = text
        textColor = color
        layer.cornerRadius = 10
        layer.borderWidth = 3
        layer.borderColor = color.cgColor
        textAlignment = .center
        alpha = 0
    }
    
    //その他のtextLabelが白のラベル
    init(text: String, font: UIFont) {
        super.init(frame: .zero)
        
        self.font = font
        textColor = .white
        self.text = text
        numberOfLines = 0
        lineBreakMode = .byWordWrapping

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
