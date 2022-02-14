//
//  BaseLabel.swift
//  Trip
//
//  Created by jh on 2022/01/27.
//

import Foundation
import UIKit

class BaseLabel: UILabel{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        self.font = BaseFont.main
        self.textColor = BaseColor.title
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
        self.lineBreakMode = .byWordWrapping
    }
}
