//
//  detailCategoryCollectionViewCell.swift
//  Parting
//
//  Created by 박시현 on 2023/06/12.
//

import UIKit
import SnapKit

class DetailCategoryCollectionViewCell: UICollectionViewCell {
    let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 16)
        label.textColor = AppColor.white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        contentView.backgroundColor = UIColor(hexcode: "D9D9E2")
        contentView.layer.cornerRadius = 8
        categoryNameLabel.textColor = AppColor.white
        
        contentView.addSubview(categoryNameLabel)
        
        categoryNameLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView).inset(12)
            make.verticalEdges.equalTo(contentView).inset(4)
        }
    }
    
    func fill(with text: String) {
        self.categoryNameLabel.text = text
    }
    
    func changeCellState(_ isClicked: Bool) {
        if isClicked {
            contentView.backgroundColor = AppColor.brand
        } else {
            contentView.backgroundColor = UIColor(hexcode: "D9D9E2")
        }
    }
}
