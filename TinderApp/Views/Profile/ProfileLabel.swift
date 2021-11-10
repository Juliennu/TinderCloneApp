//
//  ProfileLabel.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/11/02.
//

import UIKit

class ProfileLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        
        self.font = .systemFont(ofSize: 30, weight: .bold)
        self.textColor = .black
    }
    
    //infoCollectionViewCellのtitlelabel
    init(title: String) {
        super.init(frame: .zero)
        self.text = title
        self.textColor = .darkGray
        self.font = .systemFont(ofSize: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
