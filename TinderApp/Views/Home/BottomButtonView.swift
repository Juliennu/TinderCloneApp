//
//  BottomButtonView.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/22.
//

import UIKit

class ButtomButtonView: UIView {
    
    var button: BottomButton?
    
    init(frame: CGRect = .zero, width: CGFloat, imageName: String) {
        super.init(frame: frame)
        
        button = BottomButton(type: .custom)//.systemだとボタン色が青くなる
        let image = UIImage(named: imageName)
        let imageSize = width * 0.4
        let resizeImage = image?.resize(size: .init(width: imageSize, height: imageSize))
        button?.setImage(resizeImage, for: .normal )
        button?.translatesAutoresizingMaskIntoConstraints = false
        button?.backgroundColor = .white
        button?.layer.cornerRadius = width / 2
        
        //影をつける
        button?.layer.shadowOffset = .init(width: 1.5, height: 2)
        button?.layer.shadowColor = UIColor.black.cgColor
        button?.layer.shadowOpacity = 0.3
        button?.layer.shadowRadius = 15
        
        addSubview(button!)
        
        button?.anchor(centerY: centerYAnchor, centerX: centerXAnchor, width: width, height: width)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


