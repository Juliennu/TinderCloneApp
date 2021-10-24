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
    init(frame: CGRect = .zero, labelText: String, color: UIColor) {//frameに初期値0を設定
        super.init(frame: frame)
        
        font = .boldSystemFont(ofSize: 45)
        text = labelText
        textColor = color
        layer.cornerRadius = 10
        layer.borderWidth = 3
        layer.borderColor = color.cgColor
        textAlignment = .center
        alpha = 0
    }
    
    //その他のtextLabelが白のラベル
    init(frame: CGRect = .zero, labelText: String, labelFont: UIFont) {
        super.init(frame: frame)
        
        font = labelFont
        textColor = .white
        text = labelText
        numberOfLines = 0
        lineBreakMode = .byWordWrapping

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
