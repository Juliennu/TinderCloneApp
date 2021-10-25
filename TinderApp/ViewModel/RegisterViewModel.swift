//
//  RegisterViewModel.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/25.
//

import Foundation
import RxSwift
import RxCocoa

protocol RegisterViewModelInputs {
    var nameTextInput: AnyObserver<String> { get }
    var emailTextInput: AnyObserver<String> { get }
    var passwordTextInput: AnyObserver<String> { get }
}

protocol RegisterViewModelOutputs {
    var nameTextOutput: PublishSubject<String> { get }
    var emailTextOutput: PublishSubject<String> { get }
    var passwordTextOutput: PublishSubject<String> { get }
}


class RegisterViewModel: RegisterViewModelInputs, RegisterViewModelOutputs {
    
    private let disposeBag = DisposeBag()
    
    // MARK: observable
    //output: ViewModelから出ていく情報
    var nameTextOutput = PublishSubject<String>()
    var emailTextOutput = PublishSubject<String>()
    var passwordTextOutput = PublishSubject<String>()
    var validRegisterSubjet = BehaviorSubject<Bool>(value: false)
    
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
    
    //ViewControllerへ送る情報を格納
    var validRegisterDriver: Driver<Bool> = Driver.never()
    
    //入力情報をチェックしボタンのisEnabledを変更する
    init() {
        
        validRegisterDriver = validRegisterSubjet
            .asDriver(onErrorDriveWith: Driver.empty())
        
        let nameValid = nameTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count > 0
            }
        
        let emailValid = emailTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 5
            }
        
        let passwordValid = passwordTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 6
            }
        
        //3つの引数が全てtrueだったらtrueを流す。１つでもfalseがあるとfalseを流す。
        Observable.combineLatest(nameValid, emailValid, passwordValid) { $0 && $1 && $2 }
        .subscribe { validAll in
            self.validRegisterSubjet.onNext(validAll)
        }
        .disposed(by: disposeBag)

    }
}
