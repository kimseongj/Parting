//
//  HashTagCollectionViewCell.swift
//  Parting
//
//  Created by 박시현 on 2023/08/30.
//

import UIKit

class HashTagCollectionViewCell: UICollectionViewCell {
    private let cellConatiner: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.gray200
        view.clipsToBounds = true
        return view
    }()
    
    let hashTagNameLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.font = AppleSDGothicNeoFont.Bold.of(size: 13)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellConatiner.layer.cornerRadius = cellConatiner.frame.height / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeConfigures()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConfigures() {
        
        contentView.addSubview(cellConatiner)
        cellConatiner.addSubview(hashTagNameLabel)
    }
    
    func makeConstraints() {
        cellConatiner.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.width.equalToSuperview()
        }
        
        hashTagNameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configureCell(name: String) {
        hashTagNameLabel.text = name
    }
}
