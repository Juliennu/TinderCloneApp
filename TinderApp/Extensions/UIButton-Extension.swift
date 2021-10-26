//
//  UIButton-Extension.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/25.
//

import UIKit

extension UIButton {
    
    func createCardInfoButton() -> UIButton {
        let buttonImage = UIImage(systemName: "info.circle.fill")?
            //サイズ調整
            .resize(size: .init(width: 40, height: 40))
        self.setImage(buttonImage, for: .normal)
        self.tintColor = .white
        self.imageView?.contentMode = .scaleAspectFit
        return self
    }
    
    func creatAboutAccountButton(title: String) -> UIButton {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        return self
    }
}
