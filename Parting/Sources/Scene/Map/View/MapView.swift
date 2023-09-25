//
//  MapView.swift
//  Parting
//
//  Created by 박시현 on 2023/07/14.
//

import UIKit
import SnapKit
import NMapsMap

final class MapView: BaseView {

    let bellBarButton = BarImageButton(imageName: Images.sfSymbol.bell)
    
    let navigationLabel: BarTitleLabel = BarTitleLabel(text: "지도로 보기")
    
    let backBarButton = BarImageButton(imageName: Images.icon.back)
    
    let mapView: NMFNaverMapView = {
        let view = NMFNaverMapView()
        return view
    }()
    
    override func makeConfigures() {
        super.makeConfigures()
        [mapView].forEach{ self.addSubview($0)}
    }
    
    override func makeConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaInsets)
        }
    }
}
