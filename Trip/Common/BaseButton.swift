//
//  BaseButton.swift
//  Trip
//
//  Created by jh on 2022/01/25.
//

import UIKit

class BaseButton: UIButton{

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        self.titleLabel?.font = UIFont(name: BaseFont.semiBold, size: 14)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.isEnabled = false
//        self.tintColor = .red
        self.setTitleColor(.white, for: .disabled)
        self.setTitleColor(.white, for: .normal)
        self.layer.backgroundColor = BaseColor.subPoint.cgColor
        self.adjustsImageWhenHighlighted = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }

}
