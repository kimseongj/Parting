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
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.font = notoSansFont.Bold.of(size: 13)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeConfigures()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConfigures() {
        contentView.addSubview(hashTagNameLabel)
    }
    
    func makeConstraints() {
        hashTagNameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureCell(name: String) {
        hashTagNameLabel.text = name
    }
}
