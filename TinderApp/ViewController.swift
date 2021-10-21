//
//  ViewController.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()

        
        
    }
    
    func setUpViews() {
        
        view.backgroundColor = .white
        
        let view1 = UIView()
        view1.backgroundColor = .yellow
        
        let view2 = UIView()
        view2.backgroundColor = .systemPink
        
        let view3 = UIView()
        view3.backgroundColor = .purple
        
        
        let stackView = UIStackView(arrangedSubviews: [view1, view2, view3])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //垂直揃え
        stackView.axis = .vertical
        //均等に配置
//        stackView.distribution = .fillEqually
        
        self.view.addSubview(stackView)
        
        //StackViewのレイアウト
        [
            view1.heightAnchor.constraint(equalToConstant: 100),
            view3.heightAnchor.constraint(equalToConstant: 100),
            
            //safeAreaを除外する
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
            .forEach { $0.isActive = true }
    }


}


