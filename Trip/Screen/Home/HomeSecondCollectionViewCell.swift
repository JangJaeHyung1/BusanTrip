//
//  HomeSecondCollectionViewCell.swift
//  Trip
//
//  Created by jh on 2022/02/07.
//

import UIKit
import RxCocoa
import RxSwift

class HomeSecondCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "test")
        img.backgroundColor = .gray
        img.layer.cornerRadius = 10
        img.layer.masksToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let heartIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "akar-icons_heart")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        return view
    }()
    
    private let title: BaseLabel = {
        let lbl = BaseLabel()
        lbl.textColor = BaseColor.title
        lbl.font = BaseFont.normal
        lbl.numberOfLines = 1
        lbl.text = "위치 1번"
        return lbl
    }()
    
    private let subTitle: BaseLabel = {
        let lbl = BaseLabel()
        lbl.textColor = BaseColor.main
        lbl.numberOfLines = 1
        lbl.font = BaseFont.normal
        lbl.text = "위치 주소"
        return lbl
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        addSubview(imageView)
        addSubview(heartIcon)
        addSubview(title)
        addSubview(subTitle)
        
        setConstraints()
    }
    
    private func setConstraints(){
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        heartIcon.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true
        heartIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6).isActive = true
        heartIcon.widthAnchor.constraint(equalTo: heartIcon.heightAnchor).isActive = true
        heartIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
        
        subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4).isActive = true
        subTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
        subTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4).isActive = true
    }
}
