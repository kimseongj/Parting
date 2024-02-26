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
import FSCalendar

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
        rootView.hideMyPartyListView()
    }
    
    override func viewDidLayoutSubviews() {
        rootView.configureMyPartyListView()
    }
    
    private func cellResigster() {
        rootView.categoryCollectionView.register(TestViewCollectionViewCell.self, forCellWithReuseIdentifier: TestViewCollectionViewCell.identifier)
    }
    
    private func setDatasourceAndDelegate() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        rootView.myPartyCollectionView.dataSource = self
        rootView.calendarView.dataSource = self
        rootView.calendarView.delegate = self
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
            .bind(to: rootView.categoryCollectionView.rx.items(cellIdentifier: TestViewCollectionViewCell.identifier, cellType: TestViewCollectionViewCell.self)) { index, partyType, cell in
                guard let categoryImage = CategoryTitleImage(rawValue: index)?.item else { return }
                cell.configureCell(item: partyType, image: categoryImage)
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
        
        bindCalendarViewEvent()
    }
}

//MARK: - 현재 위치 갱신
extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            UserLocationManager.userLat = location.coordinate.latitude
            UserLocationManager.userLng = location.coordinate.longitude
            print("사용자 현재 위치 위경도: \(UserLocationManager.userLat), \(UserLocationManager.userLng )")
        }
    }
}

//MARK: - bindCalendarViewEvent
extension HomeViewController {
    func bindCalendarViewEvent() {
        rootView.calendarView.rx.tapGesture().when(.recognized).bind(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.viewModel.pushScheduleCalendarVC()
        })
        .disposed(by: disposeBag)
        
        viewModel.state.calendarData.withUnretained(self).bind(onNext: {owner, _ in
            owner.rootView.calendarView.reloadData()
        })
        .disposed(by: disposeBag)
    }
}

//MARK: - MyPartyCollectionView DataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPartyCell.identifier, for: indexPath) as? MyPartyCell else { return UICollectionViewCell() }
        
        return cell
    }
}

//MARK: - Calendar DataSource & Delegate
extension HomeViewController: FSCalendarDelegate {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let currentDate = rootView.calendarView.currentPage
        rootView.calendarLabel.text = DateFormatterManager.dateFormatter.makeMonthDate(date: currentDate) + " 팟팅 일정"
        viewModel.getCalendarInfo(date: currentDate)
        
    }
}

extension HomeViewController: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints { make in
            make.height.equalTo(bounds.height + 10)
        }
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if viewModel.state.calendarData.value.contains(date){
            return 1
        }
        return 0
    }
}

extension HomeViewController: FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        if viewModel.state.calendarData.value.contains(date) {
            return AppColor.brand
        } else {
            return nil
        }
    }
}
