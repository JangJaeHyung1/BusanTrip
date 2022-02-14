//
//  ViewController.swift
//  Trip
//
//  Created by jh on 2022/01/13.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
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
    
    let signInBtn: BaseButton = {
        let btn = BaseButton()
        btn.setTitle("로그인", for: .normal)
        btn.isEnabled = false
        return btn
    }()
    
    let signUpBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("회원가입", for: .normal)
        btn.setTitleColor(UIColor(red: 0.506, green: 0.506, blue: 0.506, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont(name: BaseFont.semiBold, size: 14)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let signUpLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = UIColor(red: 0.506, green: 0.506, blue: 0.506, alpha: 1)
        lbl.font = UIFont(name: BaseFont.regular, size: 14)
        lbl.text = "아직 회원이 아니신가요?"
        return lbl
    }()
    
    lazy var signUpBtnStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [signUpLbl,signUpBtn])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 6
        return sv
    }()
    
    private let disposeBag = DisposeBag()
    private let viewModel = SignInViewModel()
    private let signUpTap = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setConstraints()
        bind()
    }
    
    func setup() {
        view.backgroundColor = .white
        signUpLbl.addGestureRecognizer(signUpTap)
        signUpLbl.isUserInteractionEnabled = true
        hideTextFieldKeyboardWhenTappedBackground()
        addViews()
    }
    
    private func addViews() {
        view.addSubview(signUpBtn)
        view.addSubview(idTf)
        view.addSubview(pwTf)
        view.addSubview(signInBtn)
        view.addSubview(signUpLbl)
        view.addSubview(signUpBtnStackView)
    }
    
    private func bind(){
        
        signUpBtn.rx.tap
            .subscribe(onNext:{ [unowned self] _ in
                let rootVC = SignUpViewController()
                self.present(rootVC, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        signUpTap.rx.event
            .subscribe(onNext:{ [unowned self] _ in
                let rootVC = SignUpViewController()
                self.present(rootVC, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        signInBtn.rx.tap
            .subscribe(onNext:{ [unowned self] _ in
                let rootVC = HomeViewController()
                self.navigationController?.pushViewController(rootVC, animated: true)
            })
            .disposed(by: disposeBag)
        
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
        
        viewModel.output.isValid
            .asObservable()
            .observe(on: MainScheduler.instance)
            .map{ [unowned self] flag in
                if !flag {
                    self.signInBtn.backgroundColor = BaseColor.subPoint
                } else {
                    self.signInBtn.backgroundColor = BaseColor.point
                }
                return flag
            }
            .bind(to: signInBtn.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    private func setConstraints() {
        
        idTf.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height/3).isActive = true
        idTf.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        idTf.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        idTf.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        pwTf.widthAnchor.constraint(equalTo: idTf.widthAnchor).isActive = true
        pwTf.topAnchor.constraint(equalTo: idTf.bottomAnchor, constant: 16).isActive = true
        pwTf.centerXAnchor.constraint(equalTo: idTf.centerXAnchor).isActive = true
        pwTf.heightAnchor.constraint(equalTo: idTf.heightAnchor).isActive = true
        
        signInBtn.widthAnchor.constraint(equalTo: pwTf.widthAnchor).isActive = true
        signInBtn.topAnchor.constraint(equalTo: pwTf.bottomAnchor, constant: 34).isActive = true
        signInBtn.centerXAnchor.constraint(equalTo: pwTf.centerXAnchor).isActive = true
        signInBtn.heightAnchor.constraint(equalTo: pwTf.heightAnchor).isActive = true

        signUpBtnStackView.topAnchor.constraint(equalTo: signInBtn.bottomAnchor, constant: 56).isActive = true
        signUpBtnStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
}

