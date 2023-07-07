//
//  CategoryImageCollectionViewCell.swift
//  Parting
//
//  Created by 박시현 on 2023/04/29.
//

import UIKit
import SnapKit

class CategoryImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryImageCollectionViewCell"
    
	enum CellType {
		case normal
		case deselectable
	}
	
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
		let view = StackView(axis: .vertical, alignment: .fill, distribution: .equalSpacing, spacing: 8.0)
//        view.axis = .vertical
//        view.distribution = .fillProportionally
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
		addSubviews()
		configureCell(type: .deselectable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	override func layoutSubviews() {
		makeConstraints()
	}
	
	func configureCell(type: CategoryImageCollectionViewCell.CellType) {
		
		switch type {
		case .deselectable:
			interestsImageView.alpha = 0.6
			interestsLabel.textColor = AppColor.gray400
		case .normal:
			interestsImageView.alpha = 1
			interestsLabel.textColor = AppColor.baseText
			interestsLabel.font = notoSansFont.Light.of(size: 14)
	
			
		}
	}
}

extension CategoryImageCollectionViewCell: ProgrammaticallyInitializableViewProtocol {

	
	func addSubviews() {
		interestStackView.addArrangedSubview(interestsImageView)
		interestStackView.addArrangedSubview(interestsLabel)
		
		self.addSubview(interestStackView)
	}
	
	func makeConstraints() {
		interestStackView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		let width = self.frame.width

//		interestsImageView.snp.makeConstraints { make in
//			make.height.equalTo(width)
//			make.width.equalTo(width)
//		}
//
//		interestsLabel.snp.makeConstraints { make in
//			make.top.equalTo(interestsImageView.snp.bottom).offset(5)
//			make.centerX.equalToSuperview()
//		}
	}
	
	
}
