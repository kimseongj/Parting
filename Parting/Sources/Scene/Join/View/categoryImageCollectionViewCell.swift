//
//  categoryImageCollectionViewCell.swift
//  Parting
//
//  Created by 박시현 on 2023/04/29.
//

import UIKit
import SnapKit

class categoryImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "categoryImageCollectionViewCell"
    
    let interestsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0.6
        return imageView
    }()
    
    let interestsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = notoSansFont.Bold.of(size: 14)
        label.textColor = AppColor.gray400
        return label
    }()
    
    let interestStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillProportionally
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraints() {
        interestStackView.addArrangedSubview(interestsImageView)
        interestStackView.addArrangedSubview(interestsLabel)
        
        self.addSubview(interestStackView)

        
        interestStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        interestsImageView.snp.makeConstraints { make in
            make.height.equalTo(77)
            make.width.equalTo(interestsImageView.snp.height)
        }
        
        interestsLabel.snp.makeConstraints { make in
            make.top.equalTo(interestsImageView.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(24)
        }
    }
}
