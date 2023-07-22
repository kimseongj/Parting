//
//  BottomSheetView.swift
//  Parting
//
//  Created by 박시현 on 2023/07/19.
//

import UIKit
import SnapKit

class BottomSheetView: BaseView {
    let locationLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        return label
    }()
    
    let pageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = AppColor.brand
        return label
    }()
    
    let centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        return label
    }()
    
    let testCollectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemCyan
        return view
    }()
    
//    let categoryCollectionView: UICollectionView = {
//        let collectionView = UICollectionView()
//        collectionView.backgroundColor = .green
//        return collectionView
//    }()
    
    let lineLabel: UILabel = {
        let label = UILabel()
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.systemPink.cgColor
        return label
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .brown
        return button
    }()
    
    override func makeConfigures() {
        super.makeConfigures()
        [locationLabel, pageLabel, centerView, categoryLabel, dateLabel, testCollectionView, lineLabel, closeButton].forEach {
            addSubview($0)
        }
    }
    
    override func makeConstraints() {
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(18)
            make.leading.equalTo(30)
            make.width.equalTo(135)
            make.height.equalTo(26)
        }
        
        pageLabel.snp.makeConstraints { make in
            make.top.equalTo(18)
            make.trailing.equalToSuperview().inset(24)
            make.width.equalTo(47)
            make.height.equalTo(26)
        }
        
        centerView.snp.makeConstraints { make in
            make.top.equalTo(pageLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(108)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(centerView.snp.bottom).offset(5)
            make.leading.equalTo(24)
            make.width.equalTo(88)
            make.height.equalTo(23)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(centerView.snp.bottom).offset(5)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(150)
            make.height.equalTo(19)
        }
        
        testCollectionView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(9)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(30)
        }
        
        lineLabel.snp.makeConstraints { make in
            make.top.equalTo(testCollectionView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(lineLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(38)
            make.height.equalTo(33)
        }
    }
}
