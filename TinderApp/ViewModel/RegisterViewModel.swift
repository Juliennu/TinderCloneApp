//
//  RegisterViewModel.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/25.
//

import Foundation
import RxSwift

//登録情報が正しいかチェックする
class RegisterViewModel {
    
    private let disposeBag = DisposeBag()
    
    // MARK: observable
    //output: ViewModelから出ていく情報
    var nameTextOutput = PublishSubject<String>()
    var emailTextOutput = PublishSubject<String>()
    var passwordTextOutput = PublishSubject<String>()
    
    // MARK: observer
    //input: ViewControllerから入ってくる情報
    var nameTextInput: AnyObserver<String> {
        nameTextOutput.asObserver()
    }
    
    var emailTextInput: AnyObserver<String> {
        emailTextOutput.asObserver()
    }
    
    var passwordTextInput: AnyObserver<String> {
        passwordTextOutput.asObserver()
    }
    
    
    init() {
        
        nameTextOutput
            .asObservable()
            .subscribe { text in
                print("name: ", text)
            }
            .disposed(by: disposeBag)
        
        emailTextOutput
            .asObservable()
            .subscribe { text in
                print("email: ", text)
            }
            .disposed(by: disposeBag)
        
        passwordTextOutput
            .asObservable()
            .subscribe { text in
                print("password: ", text)
            }
            .disposed(by: disposeBag)

    }
}
