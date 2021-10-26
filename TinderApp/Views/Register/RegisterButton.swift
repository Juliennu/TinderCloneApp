//
//  RegisterButton.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/25.
//

import UIKit

class RegisterButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.backgroundColor = Colors.lightPinkColor
            } else {
                self.backgroundColor = Colors.pinkColor
            }
        }
    }
    
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        backgroundColor = Colors.pinkColor
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
