//
//  TestView.swift
//  Parting
//
//  Created by 박시현 on 2023/09/21.
//

import UIKit
import SnapKit

class TestView: BaseView {
    let naviCustomView: UIView = {
        let view = UIView()
        return view
    }()
    
    let mainBackgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    let categoryCollectionView: UICollectionView = {
        let view = UICollectionView()
        return view
    }()
    
    let calendarLabel: UILabel = {
        let label = UILabel()
        label.text = "11월 팟팅 일정"
        label.font = AppFont.SemiBold.of(size: 16)
        label.textColor = AppColor.gray900
        return label
    }()
    
    override func makeConfigures() {
        
    }
    
    override func makeConstraints() {
        
    }
}
