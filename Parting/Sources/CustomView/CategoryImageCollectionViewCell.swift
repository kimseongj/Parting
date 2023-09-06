//
//  CategoryImageCollectionViewCell.swift
//  Parting
//
//  Created by 박시현 on 2023/07/24.
//

import UIKit
import RxSwift

class CategoryImageCollectionViewCell: UICollectionViewCell {
//    static let identifier = "CategoryImageCollectionViewCell"
    enum CellType {
        case normal
        case deselectable
    }
    
    enum CellSize {
        case md
        case lg
    }
    
    private let cellType: CellType = .deselectable
    
    let interestsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0.6
        return imageView
    }()
    
    let interestsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.sizeToFit()
        label.numberOfLines = 0
        label.font = notoSansFont.Medium.of(size: 14)
        label.textColor = AppColor.gray400
        return label
    }()
    
    let interestStackView: UIStackView = {
        let view = StackView(axis: .vertical, alignment: .fill, distribution: .fillProportionally, spacing: 8.0)
        //        view.axis = .vertical
        //        view.distribution = .fillProportionally
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureCell(type: .deselectable, size: .md)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        makeConstraints()
    }
    
    func configureCell(type: CategoryImageCollectionViewCell.CellType, size: CategoryImageCollectionViewCell.CellSize) {
        var imageViewWidth: CGFloat
        
        switch type {
        case .deselectable:
            interestsImageView.alpha = 0.6
            interestsLabel.textColor = AppColor.gray400
        case .normal:
            interestsImageView.alpha = 1
            interestsLabel.textColor = AppColor.baseText
        }
        
        switch size {
        case .lg:
            imageViewWidth = 77
        case .md:
            imageViewWidth = 55
        }
        
        interestsImageView.snp.remakeConstraints { make in
            make.height.equalTo(imageViewWidth)
            make.width.equalTo(imageViewWidth)
        }
        
        
    }
    
    func configureSelectedCell() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        interestsImageView.alpha = 0.6
        interestsLabel.textColor = AppColor.gray400
    }
}

extension CategoryImageCollectionViewCell: ProgrammaticallyInitializableViewProtocol {
    
    
    func addSubviews() {
        interestStackView.addArrangedSubview(interestsImageView)
        interestStackView.addArrangedSubview(interestsLabel)
        
        contentView.addSubview(interestStackView)
    }
    
    func makeConstraints() {
        interestStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
        }
        
        
    }
    
    
}

