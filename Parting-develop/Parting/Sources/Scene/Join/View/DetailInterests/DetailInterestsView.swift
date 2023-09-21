//
//  DetailInterestsView.swift
//  Parting
//
//  Created by 박시현 on 2023/06/10.
//

import UIKit
import SnapKit

class DetailInterestsView: BaseView {
    let detailCategoryTitle: UILabel = {
        let label = UILabel()
        label.text = """
세부 카테고리를
선택해주세요
"""
        label.numberOfLines = 2
        label.sizeToFit()
        label.font = AppFont.Medium.of(size: 22)
        return label
    }()
    
    let serviceStartButton = CompleteAndNextButton("완료")
    
    lazy var detailCategoryCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        return view
    }()
    
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(77), heightDimension: .absolute(30))
        
        let titleItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [titleItem])
        
        group.interItemSpacing = .fixed(8) // 아이템간 간격(가로)
        
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
        [detailCategoryTitle, detailCategoryCollectionView, serviceStartButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func makeConstraints() {
        detailCategoryTitle.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).inset(24)
            make.width.equalTo(140)
        }
        
        detailCategoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(detailCategoryTitle.snp.bottom).offset(36)
            make.horizontalEdges.equalToSuperview().inset(25)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        serviceStartButton.snp.makeConstraints { make in
            make.top.equalTo(detailCategoryCollectionView.snp.bottom).offset(27)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.872)
            make.height.equalTo(50)
        }
    }
}
