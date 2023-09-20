//
//  InterestsView.swift
//  Parting
//
//  Created by 박시현 on 2023/04/20.
//

import UIKit
import SnapKit

class InterestsView: BaseView {
    let setThemeLabel: UILabel = {
        let label = UILabel()
        label.text = """
모임 테마를
선택해주세요
"""
        label.numberOfLines = 2
        label.sizeToFit()
        label.font = AppFont.Medium.of(size: 22)
        return label
    }()
    
    let categoryCollectionView: UICollectionView = {
        let itemColumnSpacing: CGFloat = 30
        let sectionSpacing: CGFloat = 32
        let width: CGFloat = (UIScreen.main.bounds.width - (itemColumnSpacing * 2)) - (sectionSpacing * 2)
        let itemWidth: CGFloat = width / 3
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: 110)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 32
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    let nextStepButton = CompleteAndNextButton("다음 단계로")
    
    override func makeConfigures() {
        super.makeConfigures()
        [setThemeLabel, categoryCollectionView, nextStepButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func makeConstraints() {
        setThemeLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).inset(24)
            make.width.equalTo(115)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(setThemeLabel.snp.bottom).offset(52)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(376)
        }
        
        nextStepButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.872)
            make.height.equalToSuperview().multipliedBy(0.061)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(38)
        }
    }
}
