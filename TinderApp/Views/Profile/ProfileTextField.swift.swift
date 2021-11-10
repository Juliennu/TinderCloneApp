//
//  ProfileTextField.swift.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/11/10.
//

import UIKit

class ProfileTextField: UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        
        self.borderStyle = .roundedRect
        self.placeholder = placeholder
        self.backgroundColor = Colors.placeholderBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


