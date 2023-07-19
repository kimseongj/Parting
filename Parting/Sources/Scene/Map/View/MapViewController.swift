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
    }
    
    private func configureMarker() {
        //MARK: - lat, lng에 해당하는 마커 생성
        marker.position = NMGLatLng(lat: 37.359291, lng: 127.105192)
        marker.mapView = rootView.mapView
        marker.iconTintColor = UIColor.red
    }
    
    private func navigationUI() {
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: rootView.navigationLabel)
        
        self.navigationItem.rightBarButtonItem = rootView.bellBarButton
    }
 
}
