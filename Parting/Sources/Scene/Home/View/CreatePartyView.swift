//
//  CreatePartyView.swift
//  Parting
//
//  Created by 박시현 on 2023/07/22.
//

import UIKit
import SnapKit


//MARK: - 수정 예정 => UICollectionView로 구현해서 Section별 Cell에 컴포넌트들 배치해야할 것 같음
class CreatePartyView: BaseView {
    let navigationLabel: BarTitleLabel = BarTitleLabel(text: "파티개설")
    let themeLabel = CreatePartyCommonLabel(text: "모임 테마 설정")
    let setPartyLabel: CreatePartyCommonLabel = CreatePartyCommonLabel(text: "파티 기본 설정")
    
    let introPartyLabel: CreatePartyCommonLabel = CreatePartyCommonLabel(text: "파티 소개")
    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false // scroll 기능 막기
        return collectionView
    }()
    
    let detailCategoryLabel = CreatePartyCommonLabel(text: "세부 카테고리")
    
    let maxSelectLabelNotiLabel: UILabel = {
        let label = UILabel()
        label.text = "최대 2개까지 중복 선택이 가능합니다."
        label.font = notoSansFont.Black.of(size: 12)
        label.textAlignment = .center
        label.textColor = UIColor(hexcode: "D0D0D0")
        return label
    }()
    
    let detailCategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    let setPartyView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    override func makeConfigures() {
        super.makeConfigures()
        [themeLabel, categoryCollectionView, detailCategoryLabel, maxSelectLabelNotiLabel, detailCategoryCollectionView, setPartyLabel, setPartyView, introPartyLabel].forEach {
            addSubview($0)
        }
    }
    
    override func makeConstraints() {
        themeLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.352)
            make.height.equalTo(24)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(themeLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(UIScreen.main.bounds.height * 0.25)
        }
        
        detailCategoryLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.352)
            make.height.equalTo(24)
        }
        
        maxSelectLabelNotiLabel.snp.makeConstraints { make in
            make.top.equalTo(detailCategoryLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4986)
            make.height.equalTo(24)
        }
        
        detailCategoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(maxSelectLabelNotiLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(UIScreen.main.bounds.height * 0.25)
        }
        
        setPartyLabel.snp.makeConstraints { make in
            make.top.equalTo(detailCategoryCollectionView.snp.bottom).offset(27)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.352)
            make.height.equalTo(24)
        }
        
        setPartyView.snp.makeConstraints { make in
            make.top.equalTo(setPartyLabel.snp.bottom).offset(9)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
    }
    
}
