//
//  PopUpViewController.swift
//  Trip
//
//  Created by jh on 2022/01/27.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class PopUpViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    private var titleText: String?
    private var messageText: String?
    private var attributedMessageText: NSAttributedString?
    private var contentView: UIView?

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        return view
    }()

    private lazy var signUpImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "signUpCompleted")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var nextBtn: BaseButton = {
        let btn = BaseButton()
        btn.setTitle("일정 만들기", for: .normal)
        btn.titleLabel?.font = BaseFont.sub
        btn.setTitleColor(.white, for: .normal)
        btn.isEnabled = true
        btn.backgroundColor = BaseColor.point
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var aroundHomeBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("괜찮아요. 천천히 둘러볼게요.", for: .normal)
        btn.titleLabel?.font = BaseFont.sub
        btn.setTitleColor(BaseColor.subPoint, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        return btn
    }()
    
    private lazy var titleLbl: BaseLabel = {
        let lbl = BaseLabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.font = BaseFont.main
        lbl.textColor = BaseColor.title
        lbl.textColor = .black
        lbl.text = "회원가입이 완료되었어요! \n지금 부산 여행 일정을 만들어볼까요?"
        return lbl
    }()
    
    private lazy var containerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 12.0
        view.alignment = .center
        return view
    }()

    private lazy var buttonStackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 14.0
        view.distribution = .fillEqually

        return view
    }()

    convenience init(titleText: String? = nil,
                     messageText: String? = nil,
                     attributedMessageText: NSAttributedString? = nil) {
        self.init()

        self.titleText = titleText
        self.messageText = messageText
        self.attributedMessageText = attributedMessageText
        /// present 시 fullScreen (화면을 덮도록 설정) -> 설정 안하면 pageSheet 형태 (위가 좀 남아서 밑에 깔린 뷰가 보이는 형태)
        modalPresentationStyle = .overFullScreen
    }

    convenience init(contentView: UIView) {
        self.init()
        self.contentView = contentView
        modalPresentationStyle = .overFullScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        makeConstraints()
//        bind()
    }

    func bind() {
        nextBtn.rx.tap
            .subscribe(onNext:{
                print("1")
            })
            .disposed(by: disposeBag)
        
        aroundHomeBtn.rx.tap
            .subscribe(onNext:{
                print("2")
            })
            .disposed(by: disposeBag)
    }
    public func addActionToButton(completion: (() -> Void)? = nil) {
        nextBtn.addAction(for: .touchUpInside) { _ in
            print("tap123")
            completion?()
        }
        aroundHomeBtn.addAction(for: .touchUpInside) { _ in
            print("tap123123")
            completion?()
        }
    }

    private func setupViews() {
        view.addSubview(containerView)
        view.addSubview(signUpImage)
        view.addSubview(titleLbl)
        view.addSubview(nextBtn)
        view.addSubview(aroundHomeBtn)
        view.backgroundColor = .black.withAlphaComponent(0.2)
    }
    private func makeConstraints() {
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
//
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1.117).isActive = true
        signUpImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        signUpImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 47).isActive = true
        signUpImage.widthAnchor.constraint(equalToConstant: 122).isActive = true
        signUpImage.heightAnchor.constraint(equalToConstant: 122).isActive = true
            
        titleLbl.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        titleLbl.topAnchor.constraint(equalTo: signUpImage.bottomAnchor, constant: 15).isActive = true
            
        nextBtn.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        nextBtn.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 26).isActive = true
        nextBtn.widthAnchor.constraint(equalToConstant: 284).isActive = true
        nextBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
        aroundHomeBtn.topAnchor.constraint(equalTo: nextBtn.bottomAnchor, constant: 21).isActive = true
        aroundHomeBtn.centerXAnchor.constraint(equalTo: nextBtn.centerXAnchor).isActive = true
        
    }
}

// MARK: - Extension

extension UIColor {
    /// Convert color to image
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}

extension UIControl {
    public typealias UIControlTargetClosure = (UIControl) -> ()

    private class UIControlClosureWrapper: NSObject {
        let closure: UIControlTargetClosure
        init(_ closure: @escaping UIControlTargetClosure) {
            self.closure = closure
        }
    }

    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }

    private var targetClosure: UIControlTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIControlClosureWrapper else { return nil }
            return closureWrapper.closure

        } set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, UIControlClosureWrapper(newValue),
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }

    public func addAction(for event: UIControl.Event, closure: @escaping UIControlTargetClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(UIControl.closureAction), for: event)
    }

}

