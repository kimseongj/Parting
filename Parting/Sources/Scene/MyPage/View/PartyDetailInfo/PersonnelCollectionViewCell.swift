//
//  PersonnelCollectionViewCell.swift
//  Parting
//
//  Created by 박시현 on 2023/08/30.
//

import UIKit
import SnapKit
import Kingfisher

class PersonnelCollectionViewCell: UICollectionViewCell {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let profileNameLabel: UILabel = {
        let label = UILabel()
        label.font = notoSansFont.Medium.of(size: 10)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeConfigures()
        makeConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConfigures() {
        [profileImageView, profileNameLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func makeConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(profileImageView.snp.width)
        }
        
        profileNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    func configureCell(name: String) {
        profileImageView.kf.setImage(with: URL(string: "https://parting-dev.s3.ap-northeast-2.amazonaws.com/categoryImage/%EC%9E%90%EA%B8%B0%EA%B0%9C%EB%B0%9C%ED%8C%9F.png"))
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
        profileNameLabel.text = name
    }
}
