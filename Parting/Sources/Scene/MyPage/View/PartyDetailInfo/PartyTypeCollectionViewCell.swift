//
//  PartyTypeCollectionViewCell.swift
//  Parting
//
//  Created by 박시현 on 2023/08/30.
//

import UIKit

class PartyTypeCollectionViewCell: UICollectionViewCell {
    
    let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.backgroundColor = UIColor(hexcode: "FFD1D1")
        label.font = AppFont.Bold.of(size: 13)
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
        contentView.addSubview(categoryNameLabel)
    }
    
    func makeConstraints() {
        categoryNameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureCell(name: String) {
        categoryNameLabel.text = name
    }
}
