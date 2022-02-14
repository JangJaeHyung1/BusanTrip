//
//  MapViewController.swift
//  Trip
//
//  Created by jh on 2022/01/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    let mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUp()
        mapkitUIUpdate()
        // Do any additional setup after loading the view.
    }
    
    private func bind() {
        
    }
    private func mapkitUIUpdate(){

            
            // NSString은 문자열에서 다른 자료형으로 변환하기 쉽기 때문에 String대신에 사용
            let lat = 35.1542634
            let lng = 129.1204897
            if (lat < 370) && (lng < 370){
                // 위도와 경도를 가지고 2D(한 점) 정보 객체를 획득
                let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)

                // 한 점에서 부터 거리(m)를 반영하여 맵의 크기를 가진 객체 획득
                let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: 300, longitudinalMeters: 300)
                // 400m, 300m로 설정
                
                // @IBOutlet myMap: MKMapView! 에 전달
                self.mapView.setRegion(coordinateRegion, animated: true)
                
                // 위치를 표시해줄 객체를 생성하고 앞에서 작성해준 위치값 객체 할당
                let point = MKPointAnnotation()
                point.coordinate = location
                self.mapView.addAnnotation(point)
            }
        }
}

extension MapViewController {
    private func setUp() {
        bind()
        setNavi()
        addViews()
        setConstraints()
    }
    private func setNavi() {
//        self.navigationItem.title = "여행 경로"
//        self.navigationController?.navigationBar.prefersLargeTitles = false
//        self.navigationItem.largeTitleDisplayMode = .always
//         self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    private func addViews() {
        view.addSubview(mapView)
    }
    private func setConstraints() {
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
//        mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        mapView.topAnchor.constraint(equalTo: mapView.superview!.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}
