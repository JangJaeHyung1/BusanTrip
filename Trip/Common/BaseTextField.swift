//
//  BaseTextField.swift
//  Trip
//
//  Created by jh on 2022/01/25.
//

import UIKit

class BaseTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        self.font = UIFont(name: BaseFont.semiBold, size: 14)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.858, green: 0.858, blue: 0.858, alpha: 1).cgColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        self.leftViewMode = .always
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.smartDashesType = .no
        self.smartQuotesType = .no
        self.smartInsertDeleteType = .no
        self.spellCheckingType = .no
    }
    

}
