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
        
        let view1 = UIView()
        view1.backgroundColor = .orange
        
        let view2 = UIView()
        view2.backgroundColor = .orange
        
        let view3 = UIView()
        view3.backgroundColor = .orange
        
        let view4 = UIView()
        view4.backgroundColor = .orange
        
        let view5 = UIView()
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
            baseStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
        ]
            .forEach { $0.isActive = true }
    }
}
