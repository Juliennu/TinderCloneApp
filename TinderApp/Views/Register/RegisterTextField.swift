//
//  RegisterTextField.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/25.
//

import UIKit

class RegisterTextField: UITextField {
    
    init(placeholderText: String, keyboardType: UIKeyboardType = .default) {
        super.init(frame: .zero)
        
        placeholder = placeholderText
        //ボーダーを角丸にする
        borderStyle = .roundedRect
        font = .systemFont(ofSize: 14)
        self.keyboardType = keyboardType
        autocapitalizationType = .none
        autocorrectionType = .no
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
