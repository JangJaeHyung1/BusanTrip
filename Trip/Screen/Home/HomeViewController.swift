//
//  SignInViewController.swift
//  Trip
//
//  Created by jh on 2022/01/14.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UITabBarController  {
    public var firstVisit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.insetsLayoutMarginsFromSafeArea = false
//        view.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        setUp()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 88
        tabBar.frame.origin.y = view.frame.height - 88
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if firstVisit == true {
            showPopUp()
        }
    }
}

extension HomeViewController {
    private func setUp() {
        setTabBar()
        setupStyle()
        setNavi()
    }
    private func setupStyle() {
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
    }
    
    private func setNavi() {
//        self.navigationItem.title = "여행 일정"
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    private func setTabBar(){
        let vc1 = FirstTabViewController()
        let vc2 = SecondViewController()
        let vc3 = ThirdViewController()
        vc1.title = "일정"
        vc2.title = "추억"
        vc3.title = "마이페이지"
        self.setViewControllers([vc1,vc2,vc3], animated: false)
        
        guard let items = self.tabBar.items else { return }
        
        let itemsImage = ["firstTabIcon","secondTabIcon","thirdTabIcon"]
        
        for x in 0...2 {
            let image = UIImage(named: itemsImage[x])?.resizedImage(Size: CGSize(width: 16, height: 16))
            
//            items[x].image = image?.resizableImage(withCapInsets: .init(top: 30, left: 0, bottom: -20, right: 0))
            items[x].image = image
        }
        
//        tabBarItem.imageInsets = .init(top: 0, left: 0, bottom: 20, right: 0)
        
        self.tabBar.tintColor = BaseColor.main
    }
}


class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.layoutMargins = .zero
        view.safeAreaLayoutGuide.accessibilityFrame = .zero
        view.insetsLayoutMarginsFromSafeArea = false
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
}

class ThirdViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.layoutMargins = .zero
        view.safeAreaLayoutGuide.accessibilityFrame = .zero
        view.insetsLayoutMarginsFromSafeArea = false
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}
