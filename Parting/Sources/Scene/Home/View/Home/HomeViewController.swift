//
//  HomeViewController.swift
//  Parting
//
//  Created by 김민규 on 2023/05/09.
//

import Foundation
import UIKit
import RxSwift
import Kingfisher
import RxCocoa
import CoreLocation

enum PartyList: Int, CaseIterable {
    case 관람팟
    case 자기개발팟
    case 문화생활팟
    case 음식팟
    case 운동팟
    case 오락팟
    case 카페팟
    case 한잔팟

    var imageNameList: String {
        switch self {
        case .관람팟:
            return "관람"
        case .자기개발팟:
            return "자기개발"
        case .문화생활팟:
            return "문화생활"
        case .음식팟:
            return "음식"
        case .운동팟:
            return "운동"
        case .오락팟:
            return "오락"
        case .카페팟:
            return "카페"
        case .한잔팟:
            return "술"
        }
    }

    static var numberOfItems: Int {
        return Self.allCases.count
    }
}

final class HomeViewController: BaseViewController<HomeView> {
    
    private var viewModel: HomeViewModel
    static var userLat: Double = 0
    static var userLng: Double = 0
    private var locationManager = CLLocationManager()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.input.onNext(.viewWillAppear)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellResigster()
        bind()
        checkDeviceLocationAuthorization()
        setDatasourceAndDelegate()
    }
    
    private func cellResigster() {
        rootView.categoryCollectionView.register(TestViewCollectionViewCell.self, forCellWithReuseIdentifier: TestViewCollectionViewCell.identifier)
    }
    
    private func setDatasourceAndDelegate() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
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
    
    private func bind() {
        viewModel.state.categories
            .bind(to: rootView.categoryCollectionView.rx.items(cellIdentifier: TestViewCollectionViewCell.identifier, cellType: TestViewCollectionViewCell.self)) { [weak self] index, partyType, cell in
                cell.configureCell(item: partyType)
            }
            .disposed(by: disposeBag)
        
        rootView.categoryCollectionView.rx
            .modelSelected(CategoryModel.self)
            .withUnretained(self)
            .subscribe(onNext: { owner, model in
                print(model.id)
                owner.viewModel.input.onNext(.didSelectedCell(model: model))
            })
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            HomeViewController.userLat = location.coordinate.latitude
            HomeViewController.userLng = location.coordinate.longitude
            print("사용자 현재 위치 위경도: \(HomeViewController.userLat), \(HomeViewController.userLng )")
        }
    }
}
