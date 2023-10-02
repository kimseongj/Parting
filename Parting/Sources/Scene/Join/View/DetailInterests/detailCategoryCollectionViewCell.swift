//
//  detailCategoryCollectionViewCell.swift
//  Parting
//
//  Created by 박시현 on 2023/06/12.
//

import UIKit
import SnapKit

protocol ButtonColorChange: AnyObject {
    func changeButtonColor(state: Bool)
}


class detailCategoryCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: ButtonColorChange?
    
    override var isSelected: Bool {
        didSet {
            configureUI()
            delegate?.changeButtonColor(state: isSelected)
        }
    }
    var isActivated: Bool
    
    let backGroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(hexcode: "FAFAFA")
        return view
    }()
    
    let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 16)
        label.textColor = AppColor.white
        return label
    }()
    
    override init(frame: CGRect) {
        isActivated = false
        super.init(frame: frame)
        setUpview()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        if isSelected {
            backGroundView.backgroundColor = AppColor.brand
            categoryNameLabel.textColor = AppColor.white
        } else {
            backGroundView.backgroundColor = UIColor(hexcode: "D9D9E2")
            categoryNameLabel.textColor = AppColor.white
        }
    }
    
    private func setUpview() {
        backGroundView.addSubview(categoryNameLabel)
//        contentView.backgroundColor = UIColor(hexcode: "D9D9E2")
        [backGroundView].forEach {
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
    
    func changeCellState(_ isClicked: Bool) {
        if isClicked {
            backGroundView.backgroundColor = AppColor.brand
        } else {
            backGroundView.backgroundColor = UIColor(hexcode: "D9D9E2")
        }
    }
}
