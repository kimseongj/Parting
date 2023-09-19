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

protocol SendCoordinate: AnyObject {
    func sendLatAndLng(_ lat: Double, _ lng: Double)
}

class SetMapViewController: BaseViewController<MapView> {
    private let viewModel: SetMapViewModel
    private let marker = NMFMarker()
    
    var locationManger = CLLocationManager()
    weak var delegate: SendCoordinate?
    
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
        setNaverMapDelegate()
        checkDeviceLocationAuthorization()
        moveCurrentPositionCamera()
    }
    
    private func naverMap() {
        rootView.mapView.showLocationButton = true
        rootView.mapView.showZoomControls = true
    }
    
    private func setNaverMapDelegate() {
        rootView.mapView.mapView.addCameraDelegate(delegate: self)
        rootView.mapView.mapView.touchDelegate = self
    }
    
    private func checkDeviceLocationAuthorization() {
        // MARK: - 지도 위치 권한 설정
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                let authorization: CLAuthorizationStatus
                if #available(iOS 14.0, *) {
                    authorization = self.locationManger.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                print(authorization, "✅")
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }
                
            } else {
                print("위치 서비스 OFF 상태, 위치 권한 요청을 못합니다.")
            }
        }
    }
    
    private func moveCurrentPositionCamera() {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManger.location?.coordinate.latitude ?? 35.88979460661547 , lng: locationManger.location?.coordinate.latitude ?? 128.61133694145016))
        cameraUpdate.animation = .easeIn
        rootView.mapView.mapView.moveCamera(cameraUpdate)
    }
    
    private func setLocationDelegate() {
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization() // 위치 서비스 권한 허용 팝업
    }
    
    // MARK: - 사용자의 현재 권한 허용 상태 확인
    private func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            print("authorizedAlways")
        case .notDetermined:
            locationManger.desiredAccuracy = kCLLocationAccuracyBest // 정확도 설정
            locationManger.requestWhenInUseAuthorization() // 위치 사용 허용 팝업
        case .authorizedWhenInUse:
            locationManger.startUpdatingLocation() // 현재 위치 가져오기
        case .denied:
            print("denied")
            showLocationSettingAlert()
        case .restricted:
            print("restricted")
        default:
            break
        }
    }
    
    // MARK: - 위치 권환 허용 유도 알럿
    private func showLocationSettingAlert() {
            let alert = UIAlertController(
                title: "위치 정보 이용",
                message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요",
                preferredStyle: .alert
            )
            
            let goSetting = UIAlertAction(
                title: "설정으로 이동",
                style: .default
            ) { _ in
                if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSetting)
                }
            }
            
            let cancel = UIAlertAction(
                title: "취소",
                style: .cancel
            )
            
            alert.addAction(goSetting)
            alert.addAction(cancel)
            
            self.present(alert, animated: true)
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
    
    private func setlocationPopUpAlert() {
        viewModel.input.mapClicked.onNext(())
    }
    
}

extension SetMapViewController: NMFMapViewCameraDelegate {
    // MARK: 카메라 이동시 호출되는 콜백함수
    
    func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
        print("카메라가 변경됨 : reason : \(reason)")
        let cameraPosition = mapView.cameraPosition
    }
    
}

extension SetMapViewController: CLLocationManagerDelegate {
    //MARK: - 위치 정보를 받아와 위도경도를 알아내기
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
        if let location = locations.first {
            print("위도: \(location.coordinate.latitude) 경도: \(location.coordinate.longitude)")
        }
        
        locationManger.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager) {
        print("권한 상태 바뀜", #function)
        
    }
    
    
}

//MARK: - 클릭한 위치에 대한 액션 1. 좌표 얻기 2. 팝업 띄우기
extension SetMapViewController: NMFMapViewTouchDelegate {
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        print("\(latlng.lat), \(latlng.lng)")
        marker.position = NMGLatLng(lat: latlng.lat, lng: latlng.lng)
        marker.mapView = rootView.mapView.mapView
        delegate?.sendLatAndLng(latlng.lat, latlng.lng)
        setlocationPopUpAlert()
    }
}
