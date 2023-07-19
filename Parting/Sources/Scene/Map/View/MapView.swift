//
//  MapView.swift
//  Parting
//
//  Created by 박시현 on 2023/07/14.
//

import UIKit
import SnapKit
import NMapsMap

class MapView: BaseView {

    let navigationLabel: BarTitleLabel = BarTitleLabel(text: "지도로 보기")
    let mapView: NMFMapView = {
        let view = NMFMapView()
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
