//
//  CategoryImageCollectionViewCell.swift
//  Parting
//
//  Created by 박시현 on 2023/07/24.
//

import UIKit
import RxSwift

final class CategoryImageCollectionViewCell: UICollectionViewCell {
    let imageBgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10.4
        view.layer.borderColor = AppColor.gray50.cgColor
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
        label.font = AppFont.Medium.of(size: 16)
        label.textColor = AppColor.gray700
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        makeConstraints()
    }
    
    func configureCell(item: String, model: CategoryModel) {
        interestsImageView.image = UIImage(named: item)
        interestsLabel.text = model.name
    }
    
    func configureCategoryName(item: String) {
        interestsImageView.image = UIImage(named: item)
        interestsLabel.text = item + "팟"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        interestsLabel.textColor = AppColor.gray700
    }
}

extension CategoryImageCollectionViewCell: ProgrammaticallyInitializableViewProtocol {
    func addSubviews() {
        imageBgView.addSubview(interestsImageView)
        contentView.addSubview(imageBgView)
        contentView.addSubview(interestsLabel)
    }
    
    func makeConstraints() {
        imageBgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(imageBgView.snp.height)
            make.centerX.equalToSuperview()
        }
        
        interestsImageView.snp.makeConstraints { make in
            make.width.height.equalToSuperview().multipliedBy(0.6)
            make.center.equalToSuperview()
        }
        
        interestsLabel.snp.makeConstraints { make in
            make.top.equalTo(interestsImageView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

