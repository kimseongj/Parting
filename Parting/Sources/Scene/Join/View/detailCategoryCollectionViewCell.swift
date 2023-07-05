//
//  detailCategoryCollectionViewCell.swift
//  Parting
//
//  Created by 박시현 on 2023/06/12.
//

import UIKit
import SnapKit

class detailCategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "detailCategoryCollectionViewCell"
    
    let backGroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = AppColor.gray400
        return view
    }()
    
    let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = notoSansFont.Regular.of(size: 16)
        label.textColor = AppColor.white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpview()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpview() {
        [backGroundView,categoryNameLabel].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    private func constraints() {
        backGroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        categoryNameLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(backGroundView).inset(12)
            make.verticalEdges.equalTo(backGroundView).inset(4)
        }
    }
    
    func configure(_ text: String) {
        self.categoryNameLabel.text = text
    }
}
