//
//  SetMapViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/07/31.
//

import UIKit
import RxSwift
import RxCocoa
import NMapsMap

// 1. CoreLocation import
import CoreLocation

class SetMapViewController: BaseViewController<MapView> {
    private let viewModel: SetMapViewModel
    var locationManger = CLLocationManager()
    
    init(viewModel: SetMapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("setMapVC 메모리해제")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        navigationUI()
        naverMap()
        setLocationDelegate()
    }
    
    private func naverMap() {
        
    }
    
    private func setLocationDelegate() {
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization() // 위치 서비스 권한 허용 팝업
        
        // MARK: - 지도 위치 권한 설정
        if CLLocationManager.locationServicesEnabled() {
            print("위치 서비스 ON 상태")
            locationManger.startUpdatingLocation() // 현재위치 가져오기
            print(locationManger.location?.coordinate) // 위도, 경도 가져오기
        } else {
            print("위치 서비스 OFF 상태")
        }
    }
    
    private func navigationUI() {
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.titleView = rootView.navigationLabel
        self.navigationItem.leftBarButtonItem = rootView.backBarButton
        self.navigationItem.rightBarButtonItem = rootView.bellBarButton
    }
    
    private func bind() {
        rootView.backBarButton.innerButton.rx.tap
            .bind(to: viewModel.input.popVCTrigger)
            .disposed(by: disposeBag)
    }
    
}

extension SetMapViewController: CLLocationManagerDelegate {
    // MARK: 현 위치 좌표 가져온 후, 좌표로 카메라 이동 , 해당 좌표에 마커 표시
    
}
