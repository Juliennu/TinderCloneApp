//
//  BottomControlView.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/21.
//

import UIKit

class BottomControlView: UIView {
    
    let reloadView = ButtomButtonView(frame: .zero, width: 50, imageName: "reload")
    
    let nopeView = ButtomButtonView(frame: .zero, width: 60, imageName: "nope")
    
    let superLikeView = ButtomButtonView(frame: .zero, width: 50, imageName: "star")
    
    let likeView = ButtomButtonView(frame: .zero, width: 60, imageName: "like")
    
    let boostView = ButtomButtonView(frame: .zero, width: 50, imageName: "boost")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpStackView() {
        
        let baseStackView = UIStackView(arrangedSubviews: [reloadView, nopeView, superLikeView, likeView, boostView])
        let space: CGFloat = 10
        baseStackView.axis = .horizontal
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = space
        baseStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(baseStackView)
        
        baseStackView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: space, rightPadding: space)
    }
}
