//
//  BottomControlView.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/21.
//

import UIKit

class BottomControlView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .purple
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        
        let view1 = ButtomButtonView(frame: .zero, width: 50, imageName: "reload")
        view1.backgroundColor = .orange
        
        let view2 = ButtomButtonView(frame: .zero, width: 60, imageName: "nope")
        view2.backgroundColor = .orange
        
        let view3 = ButtomButtonView(frame: .zero, width: 50, imageName: "star")
        view3.backgroundColor = .orange
        
        let view4 = ButtomButtonView(frame: .zero, width: 60, imageName: "like")
        view4.backgroundColor = .orange
        
        let view5 = ButtomButtonView(frame: .zero, width: 50, imageName: "boost")
        view5.backgroundColor = .orange
        
        let baseStackView = UIStackView(arrangedSubviews: [view1, view2, view3, view4, view5])
        
        baseStackView.axis = .horizontal
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 10
        baseStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(baseStackView)
        
        [
            baseStackView.topAnchor.constraint(equalTo: topAnchor),
            baseStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            baseStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            baseStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
        ]
            .forEach { $0.isActive = true }
        
    }
}

class ButtomButtonView: UIView {
    
    var button: UIButton?
    
    init(frame: CGRect, width: CGFloat, imageName: String) {
        super.init(frame: frame)
        
        setUpButton(width: width, imageName: imageName)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpButton(width: CGFloat, imageName: String) {
        button = UIButton(type: .custom)//.systemだと色が青くなる
//        button?.setTitle("tap", for: .normal)
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
        
        [
            button?.centerYAnchor.constraint(equalTo: centerYAnchor),
            button?.centerXAnchor.constraint(equalTo: centerXAnchor),
            button?.widthAnchor.constraint(equalToConstant: width),
            button?.heightAnchor.constraint(equalToConstant: width)

        ]
            .forEach { $0?.isActive = true }

    }
}
