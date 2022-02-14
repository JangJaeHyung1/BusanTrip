//
//  SignInViewModel.swift
//  Trip
//
//  Created by jh on 2022/01/14.
//

import Foundation
import RxSwift
import RxRelay

class SignInViewModel {
    private let disposeBag = DisposeBag()
    
    var input = Input()
    var output = Output()
    
    struct Input {
        let id = PublishSubject<String>()
        let pw = PublishSubject<String>()
    }
    
    struct Output {
        let idValid = PublishSubject<Bool>()
        let pwValid = PublishSubject<Bool>()
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
        input.pw
            .map { $0.count >= 4 && $0.count <= 12}
            .bind(to: output.pwValid)
            .disposed(by: disposeBag)
        
        // check Valid SignUp
        Observable.combineLatest(output.idValid, output.pwValid)
            .map{ $0.0 && $0.1 }
            .bind(to: output.isValid)
            .disposed(by: disposeBag)
    }
}
