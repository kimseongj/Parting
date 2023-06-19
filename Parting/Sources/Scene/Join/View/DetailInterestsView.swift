//
//  DetailInterestsView.swift
//  Parting
//
//  Created by 박시현 on 2023/06/10.
//

import UIKit
import SnapKit

class DetailInterestsView: BaseView {
    let duplicatedChooseLabel: UILabel = {
        let label = UILabel()
        label.text = "중복 선택 가능"
        label.textColor = UIColor(hexcode: "9E9EA9")
        label.textAlignment = .center
        label.font = notoSansFont.Regular.of(size: 16)
        return label
    }()
    
    let serviceStartButton: UIButton = {
        let button = UIButton()
        button.setTitle("서비스 이용하기", for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = AppColor.brand
        button.titleLabel?.font = notoSansFont.Bold.of(size: 20)
        button.setTitleColor(AppColor.white, for: .normal)
        return button
    }()
    
    lazy var detailCategoryCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        return view
    }()
    
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(77), heightDimension: .absolute(30))
        
        let titleItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [titleItem])
        
        group.interItemSpacing = .fixed(10) // 아이템간 간격(가로)
        
        let headersize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(25))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headersize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        section.interGroupSpacing = 8 // 그룹간 간격(세로)
        section.decorationItems = [
            NSCollectionLayoutDecorationItem.background(elementKind: CustomGroupView.reuseIdentifier)
        ]
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 33
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: config)
        layout.register(CustomGroupView.self, forDecorationViewOfKind: CustomGroupView.reuseIdentifier)
        return layout
    }
    
    override func makeConfigures() {
        super.makeConfigures()
        [duplicatedChooseLabel, detailCategoryCollectionView, serviceStartButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func makeConstraints() {
        duplicatedChooseLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0.1736 * UIScreen.main.bounds.height)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.03)
        }
        
        detailCategoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(duplicatedChooseLabel.snp.bottom).offset(0.032 * UIScreen.main.bounds.height)
            make.horizontalEdges.equalToSuperview().inset(25)
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        serviceStartButton.snp.makeConstraints { make in
            make.top.equalTo(detailCategoryCollectionView.snp.bottom).offset(27)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.872)
            make.height.equalToSuperview().multipliedBy(0.061)
        }
    }
}
