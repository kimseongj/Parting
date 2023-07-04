//
//  CustomHeaderView.swift
//  Parting
//
//  Created by 박시현 on 2023/06/15.
//

import UIKit
import SnapKit

class CustomHeaderView: UICollectionReusableView {
    static var elementKind: String {
        UICollectionView.elementKindSectionHeader }
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"
        label.font = notoSansFont.Regular.of(size: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        self.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
