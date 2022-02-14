//
//  SignUpViewController.swift
//  Trip
//
//  Created by jh on 2022/01/13.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = SignUpViewModel()
    private let backBtn = UITapGestureRecognizer()
    
    let signUpTitle: BaseLabel = {
        let lbl = BaseLabel()
        lbl.text = "반가워요!\n어플이름 간단한 정보만 입력하면 돼요."
        return lbl
    }()
    
    let idTf: BaseTextField = {
        let txf = BaseTextField()
        txf.placeholder = "아이디"
        return txf
    }()
    
    let pwTf: BaseTextField = {
        let txf = BaseTextField()
        txf.placeholder = "비밀번호"
        txf.textContentType = .password
        txf.isSecureTextEntry = true
        return txf
    }()
    
    let pw2Tf: BaseTextField = {
        let txf = BaseTextField()
        txf.placeholder = "비밀번호 재입력"
//        txf.textContentType = .password
        txf.isSecureTextEntry = true
        return txf
    }()
    
    let phTf: BaseTextField = {
        let txf = BaseTextField()
        txf.placeholder = "핸드폰번호, (-) 은 제외하고 입력해주세요."
//        txf.textContentType = .telephoneNumber
        txf.keyboardType = .numberPad
        return txf
    }()

    let signUpBtn: BaseButton = {
        let btn = BaseButton()
        btn.setTitle("회원가입", for: .normal)
        btn.isEnabled = false
        return btn
    }()
    
    let backLbl: BaseLabel = {
        let lbl = BaseLabel()
        lbl.textColor = BaseColor.addition
        lbl.font = BaseFont.sub
        lbl.text = "로그인 화면으로 돌아가기"
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }
    
    private func bind(){
        
        // text 수 제한
        idTf.rx.text.orEmpty
            .scan("") { (previous, new) -> String in
                if new.count > 16 {
                    return previous ?? String(new.prefix(16))
                } else {
                    return new
                }
            }
            .subscribe(idTf.rx.text)
            .disposed(by: disposeBag)
        
        idTf.rx.text.orEmpty
            .bind(to: viewModel.input.id)
            .disposed(by: disposeBag)
        
        pwTf.rx.text.orEmpty
            .bind(to: viewModel.input.pw)
            .disposed(by: disposeBag)
        
        pw2Tf.rx.text.orEmpty
            .bind(to: viewModel.input.pw2)
            .disposed(by: disposeBag)
        
        phTf.rx.text.orEmpty
            .bind(to: viewModel.input.ph)
            .disposed(by: disposeBag)
        
        viewModel.output.isValid
            .asObservable()
            .observe(on: MainScheduler.instance)
            .map{ [unowned self] flag in
                if flag {
                    self.signUpBtn.backgroundColor = BaseColor.point
                }else {
                    self.signUpBtn.backgroundColor = BaseColor.subPoint
                }
                return flag
            }
            .bind(to: signUpBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signUpBtn.rx.tap
            .subscribe(onNext:{ [unowned self] _ in
                let root = self.view.window?.rootViewController
                self.dismiss(animated: true) {
                    let rootVC = HomeViewController()
                    rootVC.modalPresentationStyle = .fullScreen
                    rootVC.firstVisit = true
                    root?.present(rootVC, animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
        
        backBtn.rx.event
            .debug()
            .subscribe(onNext:{ [unowned self] _ in
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    private func setup() {
        view.backgroundColor = .white
        navigationItem.title = "회원가입"
        backLbl.addGestureRecognizer(backBtn)
        backLbl.isUserInteractionEnabled = true
        hideTextFieldKeyboardWhenTappedBackground()
        addViews()
        setConstraints()
    }
    
    private func addViews() {
        view.addSubview(signUpTitle)
        view.addSubview(idTf)
        view.addSubview(pwTf)
        view.addSubview(pw2Tf)
        view.addSubview(phTf)
        view.addSubview(signUpBtn)
        view.addSubview(backLbl)
    }
    

    private func setConstraints() {
        
        signUpTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        signUpTitle.leadingAnchor.constraint(equalTo: idTf.leadingAnchor).isActive = true
        
        idTf.topAnchor.constraint(equalTo: signUpTitle.bottomAnchor, constant: 40).isActive = true
        idTf.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        idTf.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        idTf.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        pwTf.widthAnchor.constraint(equalTo: idTf.widthAnchor).isActive = true
        pwTf.topAnchor.constraint(equalTo: idTf.bottomAnchor, constant: 16).isActive = true
        pwTf.centerXAnchor.constraint(equalTo: idTf.centerXAnchor).isActive = true
        pwTf.heightAnchor.constraint(equalTo: idTf.heightAnchor).isActive = true
        
        pw2Tf.widthAnchor.constraint(equalTo: idTf.widthAnchor).isActive = true
        pw2Tf.topAnchor.constraint(equalTo: pwTf.bottomAnchor, constant: 16).isActive = true
        pw2Tf.centerXAnchor.constraint(equalTo: idTf.centerXAnchor).isActive = true
        pw2Tf.heightAnchor.constraint(equalTo: idTf.heightAnchor).isActive = true
        
        phTf.widthAnchor.constraint(equalTo: idTf.widthAnchor).isActive = true
        phTf.topAnchor.constraint(equalTo: pw2Tf.bottomAnchor, constant: 16).isActive = true
        phTf.centerXAnchor.constraint(equalTo: idTf.centerXAnchor).isActive = true
        phTf.heightAnchor.constraint(equalTo: idTf.heightAnchor).isActive = true

        signUpBtn.widthAnchor.constraint(equalTo: idTf.widthAnchor).isActive = true
        signUpBtn.topAnchor.constraint(equalTo: phTf.bottomAnchor, constant: 34).isActive = true
        signUpBtn.centerXAnchor.constraint(equalTo: idTf.centerXAnchor).isActive = true
        signUpBtn.heightAnchor.constraint(equalTo: idTf.heightAnchor).isActive = true
        
        backLbl.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        backLbl.centerXAnchor.constraint(equalTo: idTf.centerXAnchor).isActive = true
    }
    
    
}
