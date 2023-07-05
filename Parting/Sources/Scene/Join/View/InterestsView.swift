//
//  InterestsView.swift
//  Parting
//
//  Created by 박시현 on 2023/04/20.
//

import UIKit
import SnapKit

class InterestsView: BaseView {
    let duplicatedChooseLabel: UILabel = {
        let label = UILabel()
        label.text = "중복 선택 가능"
        label.textColor = UIColor(hexcode: "9E9EA9")
        label.textAlignment = .center
        label.font = notoSansFont.Regular.of(size: 16)
        return label
    }()
    
    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    let nextStepButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음 단계로", for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = AppColor.brand
        button.titleLabel?.font = notoSansFont.Bold.of(size: 20)
        button.setTitleColor(AppColor.white, for: .normal)
        return button
    }()
    
    override func makeConfigures() {
        super.makeConfigures()
        [duplicatedChooseLabel, categoryCollectionView, nextStepButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func makeConstraints() {
        duplicatedChooseLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0.1736 * UIScreen.main.bounds.height)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.03)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(duplicatedChooseLabel.snp.bottom).offset(0.032 * UIScreen.main.bounds.height)
            make.horizontalEdges.equalToSuperview().inset(25)
            make.height.equalToSuperview().multipliedBy(0.516)
        }
        
        nextStepButton.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(0.065 * UIScreen.main.bounds.height)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.872)
            make.height.equalToSuperview().multipliedBy(0.061)
        }
    }
}
