//
//  MapViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/07/14.
//

import UIKit
import NMapsMap
import RxCocoa
import RxSwift
import RxGesture

import CoreLocation

final class MapViewController: BaseViewController<MapView> {
    private let viewModel: MapViewModel
    private var markers = [NMFMarker]() // 마커배열 인스턴스 생성
    var locationManager = CLLocationManager()
    var timer = Timer()
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationDelegate()
        navigationUI()
//        configureMarker()
        checkDeviceLocationAuthorization()
        naverMap()
        moveCurrentPositionCamera()
        setNaverMapDelegate()
        bindMarker()
        bindPartyDetail()
    }
    
    private func naverMap() {
        rootView.mapView.showLocationButton = true
        rootView.mapView.showZoomControls = true
    }
    
    // MARK: - SetOverlay
    private func setOverlay(lat: Double, lng: Double) {
        let locationOverlay = rootView.mapView.mapView.locationOverlay
        locationOverlay.location = NMGLatLng(lat: lat, lng: lng)
    }

    // MARK: - naverMapDelegate
    private func setNaverMapDelegate() {
        rootView.mapView.mapView.addCameraDelegate(delegate: self)
        rootView.mapView.mapView.touchDelegate = self
    }
    
    // MARK: - Navigation UI
    private func navigationUI() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: rootView.navigationLabel)
    }
    
    // MARK: - CLLocationManagerDelegate
    private func setLocationDelegate() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() // 위치 서비스 권한 허용 팝업
    }
    
    // MARK: - 지도 위치 권한 설정
    private func checkDeviceLocationAuthorization() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                let authorization: CLAuthorizationStatus // 유저의 현재 위치권한 허용 상태
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
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
    
    // MARK: - 현재위치로 카메라 변경
    private func moveCurrentPositionCamera() {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 35.88979460661547 , lng: locationManager.location?.coordinate.latitude ?? 128.61133694145016))
        cameraUpdate.animation = .easeIn
        rootView.mapView.mapView.moveCamera(cameraUpdate)
    }
    
    // MARK: - 사용자의 현재 권한 허용 상태 확인
    private func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            print("authorizedAlways")
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확도 설정
            locationManager.requestWhenInUseAuthorization() // 위치 사용 허용 팝업
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation() // 현재 위치 가져오기
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
    
    private func bindPartyMaker() {
        
    }
}

extension MapViewController: CLLocationManagerDelegate {
    //MARK: - 위치 정보를 받아와 위도경도를 알아내기
    // 위도 경도 -> 서버로 전송 -> 이 위치로부터 주변 파티 파악
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
        if let location = locations.last {
            print("위도: \(location.coordinate.latitude) 경도: \(location.coordinate.longitude)")
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: location.coordinate.latitude ?? 35.88979460661547 , lng: location.coordinate.longitude ?? 128.61133694145016))
            cameraUpdate.animation = .easeIn
            rootView.mapView.mapView.moveCamera(cameraUpdate)
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager) {
        print("권한 상태 바뀜", #function)
        
    }
}

extension MapViewController: NMFMapViewCameraDelegate {
    // MARK: 카메라 이동시 호출되는 콜백함수
    
    func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
        print("카메라가 변경됨 : reason : \(reason)")
        let cameraPosition = mapView.cameraPosition
        print(cameraPosition)
    }
    
}

//MARK: - 클릭한 위치에 대한 액션 1. 좌표 얻기 2. 팝업 띄우기
extension MapViewController: NMFMapViewTouchDelegate {
    func startAPICallDebouncer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(handleAPICall), userInfo: nil, repeats: false)
    }
    
    @objc func handleAPICall() {
        let southWest = rootView.mapView.mapView.projection.latlngBounds(fromViewBounds: self.view.frame).southWest
        let northEast = rootView.mapView.mapView.projection.latlngBounds(fromViewBounds: self.view.frame).northEast
        viewModel.searchPartyOnMap(searchHighLatitude: northEast.lat, searchHighLongitude: northEast.lng, searchLowLatitude: southWest.lat, searchLowLongitude: southWest.lng)
    }
    
    func mapViewCameraIdle(_ mapView: NMFMapView) {
        startAPICallDebouncer()
    }
    
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        rootView.hidePartyInfoView()
    }
}

extension MapViewController {
    func bindMarker() {
        
        
        viewModel.output.aroundPartyList.bind(onNext: { partyList in
            partyList.forEach { data in
    
                let marker = NMFMarker(position: NMGLatLng(lat: data.partyLatitude, lng: data.partyLongitude), iconImage: NMFOverlayImage(name: "locationMarker"))
                    marker.mapView = self.rootView.mapView.mapView

                let handler = { [weak self] (overlay: NMFOverlay) -> Bool in
                    guard let self = self else { return true }
                        self.viewModel.getMapPartyDetailInfo(partyId: data.partyID, partyLat: data.partyLatitude, partyLng: data.partyLongitude)

                        self.viewModel.output.selectedParty.bind(onNext: { data in 
                            self.rootView.partyInfoView.fill(with: data)
                            self.rootView.presentInfoView()
                        })
                        .disposed(by: disposeBag)

                    return true
                }
                
                marker.touchHandler = handler
            }
        })
        .disposed(by: disposeBag)
    }
    
    func bindPartyDetail() {
        rootView.partyInfoView.rx.tapGesture().when(.recognized)
            .bind(onNext: { _ in
            self.viewModel.pushPartyDetailViewController()
        })
        .disposed(by: disposeBag)
    }
}
