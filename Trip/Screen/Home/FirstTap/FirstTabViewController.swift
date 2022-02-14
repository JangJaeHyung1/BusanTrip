//
//  SignInViewController.swift
//  Trip
//
//  Created by jh on 2022/01/14.
//

import UIKit
import RxSwift
import RxCocoa

class FirstTabViewController: UITabBarController  {
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
//        sv.backgroundColor = .red
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let contentView: UIView = {
        let view = UIView()
//        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentViewBackgroundImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "test2")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.isUserInteractionEnabled = true
//        img.contentMode = .scaleToFill
        img.contentMode = .scaleAspectFill
        return img
    }()
    
//    lazy var searchBtn: UIButton = {
//        let btn = UIButton()
//        btn.setImage(UIImage(named: "searchImage"), for: .normal)
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.adjustsImageWhenHighlighted = false
//        btn.imageEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
//        btn.isEnabled = true
//        return btn
//    }()
    
    lazy var searchBtn: BaseButton = {
        let btn = BaseButton()
        btn.layer.backgroundColor = BaseColor.point.cgColor
        btn.isEnabled = true
        btn.tintColor = BaseColor.title
        btn.setImage(UIImage(named: "createTripSchedule"), for: .normal)
        btn.titleEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
        btn.setTitle("여행 일정 만들기    ", for: .normal)
        return btn
    }()
    
    
    let createTripSchedule: BaseButton = {
        let btn = BaseButton()
        btn.layer.backgroundColor = BaseColor.point.cgColor
        btn.isEnabled = true
        btn.tintColor = BaseColor.title
        btn.setImage(UIImage(named: "createTripSchedule"), for: .normal)
        btn.titleEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
        btn.setTitle("여행 일정 만들기    ", for: .normal)
        return btn
    }()
    
    let helloLbl: BaseLabel = {
        let lbl = BaseLabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.lineBreakMode = .byWordWrapping
        lbl.text = "안녕하세요, ㅇㅇㅇ님!\n걷기 좋은 청사포 다릿돌전망대 어때요?"
        return lbl
    }()
    
    let firstView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let firstViewTitle: BaseLabel = {
        let lbl = BaseLabel()
        lbl.text = "ㅇㅇㅇ님을 위한 추천 경로"
        return lbl
    }()
    
    private let secondViewTitle: BaseLabel = {
        let lbl = BaseLabel()
        lbl.text = "2월! 부산의 인기 지역을 모아봤어요😆"
        return lbl
    }()
    
    private let thridViewTitle: BaseLabel = {
        let lbl = BaseLabel()
        lbl.text = "(대충 꼭 가야한다고 설명하는 타이틀)"
        return lbl
    }()
    
    private let betweenView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let secondView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let secondViewLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    
    public var firstVisit = false
    private let disposeBag = DisposeBag()
    private var collectionView1: UICollectionView!
    private var collectionView2: UICollectionView!
    private var collectionView3: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutMargins = .zero
        view.safeAreaLayoutGuide.accessibilityFrame = .zero
        view.insetsLayoutMarginsFromSafeArea = false
        view.backgroundColor = .white
        setUp()
        
    }
    
    override func viewDidLayoutSubviews() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        if firstVisit == true {
//            showPopUp()
//        }
    }
    
    private func setCollectionView(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        collectionView1 = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView1.dataSource = self
        collectionView1.delegate = self
        collectionView1.showsHorizontalScrollIndicator = false
        collectionView1.showsVerticalScrollIndicator = false
        collectionView1.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "cell1")
        collectionView1.showsVerticalScrollIndicator = false
        collectionView1.translatesAutoresizingMaskIntoConstraints = false
        
        let flowLayout2 = UICollectionViewFlowLayout()
        flowLayout2.scrollDirection = .horizontal
        collectionView2 = UICollectionView(frame: .zero, collectionViewLayout: flowLayout2)
        collectionView2.dataSource = self
        collectionView2.delegate = self
        collectionView2.showsHorizontalScrollIndicator = false
        collectionView2.showsVerticalScrollIndicator = false
        collectionView2.register(HomeSecondCollectionViewCell.self, forCellWithReuseIdentifier: "cell2")
        collectionView2.showsVerticalScrollIndicator = false
        collectionView2.translatesAutoresizingMaskIntoConstraints = false

        let flowLayout3 = UICollectionViewFlowLayout()
        flowLayout3.scrollDirection = .horizontal
        collectionView3 = UICollectionView(frame: .zero, collectionViewLayout: flowLayout3)
        collectionView3.dataSource = self
        collectionView3.delegate = self
        collectionView3.showsHorizontalScrollIndicator = false
        collectionView3.showsVerticalScrollIndicator = false
        collectionView3.register(HomeSecondCollectionViewCell.self, forCellWithReuseIdentifier: "cell2")
        collectionView3.showsVerticalScrollIndicator = false
        collectionView3.translatesAutoresizingMaskIntoConstraints = false

        
    }
    
    private func bind() {
        
        let scrollRx = scrollView.rx
                    .contentOffset
                    .observe(on: MainScheduler.asyncInstance)
                    .share()

                // restrict scroll top bounce
                scrollRx
                    .map { offset -> Bool in
                        return offset.y > 100 }
                    .subscribe(onNext: {
                        self.scrollView.bounces = $0
                    })
                    .disposed(by: disposeBag)
        
        createTripSchedule.rx.tap
            .subscribe(onNext:{
                print("create schedule")
            })
            .disposed(by: disposeBag)
        
        
        searchBtn.rx.tap
            .subscribe(onNext:{
                print("tapSearch")
//                let rootVC = MapViewController()
//                self.navigationController?.pushViewController(rootVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

extension FirstTabViewController {
    private func setUp() {
        bind()
        setNavi()
        setCollectionView()
        addViews()
        setConstraints()
    }
    
    
    private func setNavi() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func addViews() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        contentView.addSubview(contentViewBackgroundImage)
        contentView.addSubview(createTripSchedule)
        contentView.addSubview(helloLbl)
        contentView.addSubview(searchBtn)
        
        contentView.addSubview(firstView)
        
        firstView.addSubview(firstViewTitle)
        firstView.addSubview(collectionView1)
        
        contentView.addSubview(betweenView)
        
        contentView.addSubview(secondView)
        secondView.addSubview(secondViewTitle)
        secondView.addSubview(collectionView2)
        
        secondView.addSubview(secondViewLine)
        
        secondView.addSubview(thridViewTitle)
        secondView.addSubview(collectionView3)
    }
    private func setConstraints() {
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: scrollView.superview!.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        contentViewBackgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        contentViewBackgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        contentViewBackgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        contentViewBackgroundImage.heightAnchor.constraint(equalToConstant: 400).isActive = true
        contentViewBackgroundImage.bottomAnchor.constraint(equalTo: firstView.topAnchor).isActive = true
        
        searchBtn.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        searchBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40).isActive = true
        searchBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        searchBtn.heightAnchor.constraint(equalToConstant: 230).isActive = true
        
        
        helloLbl.bottomAnchor.constraint(equalTo: createTripSchedule.topAnchor, constant: -26).isActive = true
        helloLbl.leadingAnchor.constraint(equalTo: createTripSchedule.leadingAnchor, constant: 5).isActive = true

        createTripSchedule.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        createTripSchedule.heightAnchor.constraint(equalToConstant: CGFloat(Btn.height)).isActive = true
        createTripSchedule.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 25).isActive = true
        createTripSchedule.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -25).isActive = true

        firstView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        firstView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        firstView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        firstView.topAnchor.constraint(equalTo: createTripSchedule.bottomAnchor, constant: Pad.size).isActive = true
        
        firstViewTitle.topAnchor.constraint(equalTo: firstView.topAnchor, constant: Pad.size).isActive = true
        firstViewTitle.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: Pad.size).isActive = true
        
        secondView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        secondView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        betweenView.topAnchor.constraint(equalTo: firstView.bottomAnchor).isActive = true
        betweenView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        betweenView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        betweenView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        
        secondView.bottomAnchor.constraint(equalTo: collectionView3.bottomAnchor, constant: 80).isActive = true
        secondView.topAnchor.constraint(equalTo: betweenView.bottomAnchor).isActive = true
        secondView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        
        collectionView1.topAnchor.constraint(equalTo: firstViewTitle.bottomAnchor, constant: Pad.size).isActive = true
        collectionView1.leadingAnchor.constraint(equalTo: firstViewTitle.leadingAnchor).isActive = true
        collectionView1.trailingAnchor.constraint(equalTo: firstView.trailingAnchor).isActive = true
        collectionView1.bottomAnchor.constraint(equalTo: firstView.bottomAnchor, constant: -50).isActive = true
        
        secondViewTitle.topAnchor.constraint(equalTo: secondView.topAnchor, constant: Pad.size).isActive = true
        secondViewTitle.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: Pad.size).isActive = true
        
        collectionView2.topAnchor.constraint(equalTo: secondViewTitle.bottomAnchor, constant: Pad.size).isActive = true
        collectionView2.leadingAnchor.constraint(equalTo: secondViewTitle.leadingAnchor).isActive = true
        collectionView2.trailingAnchor.constraint(equalTo: secondView.trailingAnchor).isActive = true
        collectionView2.heightAnchor.constraint(equalToConstant: 240).isActive = true
        
        secondViewLine.topAnchor.constraint(equalTo: collectionView2.bottomAnchor, constant: Pad.size - 16).isActive = true
        secondViewLine.leadingAnchor.constraint(equalTo: collectionView2.leadingAnchor).isActive = true
        secondViewLine.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
        secondViewLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        thridViewTitle.topAnchor.constraint(equalTo: secondViewLine.bottomAnchor, constant: Pad.size).isActive = true
        thridViewTitle.leadingAnchor.constraint(equalTo: collectionView2.leadingAnchor).isActive = true
        
        collectionView3.topAnchor.constraint(equalTo: thridViewTitle.bottomAnchor, constant: Pad.size).isActive = true
        collectionView3.leadingAnchor.constraint(equalTo: collectionView2.leadingAnchor).isActive = true
        collectionView3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        collectionView3.heightAnchor.constraint(equalToConstant: 240).isActive = true
        
        
    }
}

extension FirstTabViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionView1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! HomeCollectionViewCell
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! HomeSecondCollectionViewCell
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionView1{
            return CGSize(width: 200, height: 260)
        } else {
            return CGSize(width: 160, height: 220)
        }
    }
}
