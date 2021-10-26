//
//  RegisterTitleLabel.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/25.
//

import UIKit

class RegisterTitleLabel: UILabel {
    
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        self.font = .systemFont(ofSize: 80, weight: .heavy)//.boldSystemFont(ofSize: 80)
        self.textColor = .white
        self.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
