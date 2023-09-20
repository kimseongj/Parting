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
    let bgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.borderColor = UIColor(hexcode: "F1F1F1").cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let interestsImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let interestsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.sizeToFit()
        label.numberOfLines = 0
        label.font = AppleSDGothicNeoFont.Medium.of(size: 16)
        label.textColor = AppColor.gray700
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
//        configureCell(type: .deselectable, size: .md)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        makeConstraints()
    }
    
    func configureCell(item: String) {
        interestsImageView.image = UIImage(named: item)
        interestsLabel.text = item
    }
    
    func configureCell(type: CategoryImageCollectionViewCell.CellType, size: CategoryImageCollectionViewCell.CellSize) {
        var imageViewWidth: CGFloat
        
    }
    
    func configureSelectedCell() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        interestsLabel.textColor = AppColor.gray50
    }
}

extension CategoryImageCollectionViewCell: ProgrammaticallyInitializableViewProtocol {
    
    
    func addSubviews() {
        bgView.addSubview(interestsImageView)
        interestStackView.addArrangedSubview(bgView)
        interestStackView.addArrangedSubview(interestsLabel)
        
        contentView.addSubview(interestStackView)
    }
    
    func makeConstraints() {
        interestsImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        interestStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
}

