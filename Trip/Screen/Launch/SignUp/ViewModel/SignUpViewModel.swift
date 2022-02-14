//
//  SignUpViewModel.swift
//  Trip
//
//  Created by jh on 2022/01/14.
//

import Foundation
import RxSwift
import RxRelay

class SignUpViewModel {
    private let disposeBag = DisposeBag()
    
    var input = Input()
    var output = Output()
    
    struct Input {
        let id = PublishSubject<String>()
        let pw = PublishSubject<String>()
        let pw2 = PublishSubject<String>()
        let ph = PublishSubject<String>()
    }
    
    struct Output {
        let idValid = PublishSubject<Bool>()
        let pwValid = PublishSubject<Bool>()
        let phValid = PublishSubject<Bool>()
        let isValid = PublishRelay<Bool>()
    }
    
    init() {
        
        // check id valid
        input.id.asObserver()
            .flatMap{ nickname -> Observable<Bool> in
                let nicknameRegEx = "[A-Za-z0-9]{4,20}"
                let pred = NSPredicate(format:"SELF MATCHES %@", nicknameRegEx)
                return Observable.just(pred.evaluate(with: nickname))
            }
            .subscribe(onNext:{ [weak self] in
                self?.output.idValid.onNext($0)
            })
            .disposed(by: disposeBag)
        
        // check pw valid
        Observable.combineLatest(input.pw, input.pw2)
            .map { ($0.0 == $0.1) && $0.0.count >= 4 && $0.0.count <= 12}
            .bind(to: output.pwValid)
            .disposed(by: disposeBag)
        
        // check ph valid
        input.ph.asObserver()
            .flatMap{ phoneNumber -> Observable<Bool> in
                let regex = "^01[0-1, 7][0-9]{7,8}$"
                let pred = NSPredicate(format:"SELF MATCHES %@", regex)
                return Observable.just(pred.evaluate(with: phoneNumber))
            }
            .subscribe(onNext:{ [weak self] in
                self?.output.phValid.onNext($0)
            })
            .disposed(by: disposeBag)
        
        // check Valid SignUp
        Observable.combineLatest(output.idValid, output.pwValid, output.phValid)
            .map{ $0.0 && $0.1 && $0.2}
//            .map { _ in true }
            .bind(to: output.isValid)
            .disposed(by: disposeBag)
    }
}
