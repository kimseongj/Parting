//
//  MyPageTableViewCell.swift
//  Parting
//
//  Created by 박시현 on 2023/08/21.
//

import UIKit
import SnapKit

class MyPageTableViewCell: UITableViewCell {
    private let listImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private let listTitle: UILabel = {
        let label = UILabel()
        label.font = AppFont.Medium.of(size: 15)
        return label
    }()
    
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        
        configureLayout()
        constraintsLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        self.addSubview(listImage)
        self.addSubview(listTitle)
    }
    
    func constraintsLayout() {
        listImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
            make.leading.equalToSuperview().offset(24)
        }
        listTitle.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(13)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(listImage.snp.trailing).offset(10)
        }
    }

    func fill(title: String, image: String) {
        listImage.image = UIImage(named: image)
        listTitle.text = title
    }
}
