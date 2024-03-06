//
//  MyPageCollectionViewCell.swift
//  Parting
//
//  Created by 이병현 on 2023/09/26.
//

import UIKit
import SnapKit

class MyPageCollectionViewCell: UICollectionViewCell {
    
    private let containView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.makeRightBottomShadow()
        view.clipsToBounds = false
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = AppFont.Medium.of(size: 14)
        label.textColor = UIColor(hexcode: "363636")
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierarchy() {
        self.addSubview(containView)
        self.addSubview(imageView)
        self.addSubview(titleLabel)
    }
    
    func setLayout() {
        containView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(5)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(22)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.width.equalTo(36)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(containView)
            make.bottom.equalTo(containView.snp.bottom).offset(-8)
            make.height.equalTo(24)
        }
    }
}

extension MyPageCollectionViewCell {
    func configure(_ item: MyPageModel) {
        imageView.image = item.image
        titleLabel.text = item.title
    }
}
