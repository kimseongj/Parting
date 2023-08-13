//
//  MapViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/07/14.
//

import UIKit
import NMapsMap

class MapViewController: BaseViewController<MapView> {

    private let viewModel: MapViewModel
    private let marker = NMFMarker() // 마커 인스턴스 생성
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        configureMarker()
        markerClicked()
    }
    
    private func configureMarker() {
        //MARK: - lat, lng에 해당하는 마커 생성
        marker.position = NMGLatLng(lat:35.88979460661547, lng: 128.61133694145016)
        marker.mapView = rootView.mapView.mapView
        marker.iconTintColor = UIColor.red
    }
    
    private func navigationUI() {
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.titleView = rootView.navigationLabel
        self.navigationItem.leftBarButtonItem = rootView.backBarButton
        self.navigationItem.rightBarButtonItem = rootView.bellBarButton
    }
    
    private func markerClicked() {
        marker.touchHandler = { (marker: NMFOverlay?) -> Bool in
            //MARK: - bottom sheet 띄우기
            let bottomSheetViewController = BottomSheetViewController()
            bottomSheetViewController.modalPresentationStyle = .automatic
            self.present(bottomSheetViewController, animated: true)
            print(CreatePartyViewController.partyTitle)
            return true
        }
    }
}
