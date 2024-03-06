//
//  HashTagCollectionViewCell.swift
//  Parting
//
//  Created by 박시현 on 2023/08/30.
//

import UIKit

class HashTagCollectionViewCell: UICollectionViewCell {
    let hashTagNameLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.font = AppFont.Regular.of(size: 11)
        label.textColor = AppColor.gray500
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContentView()
        makeConfigures()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContentView() {
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor =  AppColor.gray50
    }
    
    func makeConfigures() {
        contentView.addSubview(hashTagNameLabel)
    }
    
    func makeConstraints() {
        hashTagNameLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(8)
            make.trailing.bottom.equalToSuperview().inset(8)
        }
    }
    
    func configureCell(name: String) {
        hashTagNameLabel.text = name
    }
}
