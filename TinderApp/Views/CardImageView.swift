//
//  CardImageView.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/25.
//

import UIKit

class CardImageView: UIImageView {
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        contentMode = .scaleAspectFill
        image = UIImage(named: "dogAndBards")
        //イメージが境界に合わせて切り取られる
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
