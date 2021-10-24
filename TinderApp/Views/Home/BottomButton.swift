//
//  BottomButton.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/22.
//

import UIKit

class BottomButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                //ボタン押下時は小さく、ボタンを離したら大きさが元に戻るアニメーション
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: []) {
                    //アニメーション付きで大きさを0.8倍にしてくれる
                    self.transform = .init(scaleX: 0.8, y: 0.8)
                    self.layoutIfNeeded()
                }
                
            } else {
                //ハイライトが終わった時
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: []) {
                    //元の大きさに戻ってくれる
                    self.transform = .identity
                    self.layoutIfNeeded()
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
