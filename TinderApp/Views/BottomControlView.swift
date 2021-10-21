//
//  BottomControlView.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/21.
//

import UIKit

class BottomControlView: UIView {
    
    let view1 = ButtomButtonView(frame: .zero, width: 50, imageName: "reload")
    
    let view2 = ButtomButtonView(frame: .zero, width: 60, imageName: "nope")
    
    let view3 = ButtomButtonView(frame: .zero, width: 50, imageName: "star")
    
    let view4 = ButtomButtonView(frame: .zero, width: 60, imageName: "like")
    
    let view5 = ButtomButtonView(frame: .zero, width: 50, imageName: "boost")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        
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
