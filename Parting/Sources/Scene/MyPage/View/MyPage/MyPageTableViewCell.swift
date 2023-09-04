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
        label.font = notoSansFont.Medium.of(size: 20)
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
            make.verticalEdges.leading.equalToSuperview().inset(13)
            make.width.equalTo(listImage.snp.height)
        }
        listTitle.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(13)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(listImage.snp.trailing).offset(10)
        }
    }
    
    func configureCell(title: String, image: String) {
        listImage.image = UIImage(named: image)
        listTitle.text = title
    }

}
