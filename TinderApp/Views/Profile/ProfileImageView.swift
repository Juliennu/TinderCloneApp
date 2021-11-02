//
//  ProfileImageView.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/11/02.
//

import UIKit

class ProfileImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        
        self.image = UIImage(named: "dog&birds")
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 90
        //Viewにセットしたコンテンツが領域(bonds)の外側を描写するかどうかを決定する。
        //デフォルト値はfalse(これをtrueにしないとcornerRadiousが反映されない)
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
