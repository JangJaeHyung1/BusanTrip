//
//  HomeCollectionViewCell.swift
//  Trip
//
//  Created by jh on 2022/02/05.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "test")
        img.backgroundColor = .gray
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
        lbl.text = "겨울 바다? 오히려 좋아"
        return lbl
    }()
    
    private let subTitle: BaseLabel = {
        let lbl = BaseLabel()
        lbl.textColor = BaseColor.main
        lbl.numberOfLines = 2
        lbl.font = BaseFont.normal
        lbl.text = "청사포 다릿돌전망대 → 송정 해수욕장 → 이것저것 → ..."
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
        imageView.addSubview(titleView)
        titleView.addSubview(title)
        titleView.addSubview(subTitle)
        
        setConstraints()
    }
    
    private func setConstraints(){
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        titleView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        title.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 18).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        
        subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 12).isActive = true
        subTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        subTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
}
