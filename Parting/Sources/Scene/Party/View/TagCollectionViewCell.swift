//
//  TagCollectionViewCell.swift
//  Parting
//
//  Created by 김민규 on 2023/07/14.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    let textLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.font = AppFont.Regular.of(size: 11)
        label.textColor = AppColor.gray500
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
        configureContentView()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContentView() {
        contentView.backgroundColor = AppColor.gray50
        contentView.layer.cornerRadius = 8
    }
    
    func fill(with text: String) {
        textLabel.text = text
    }
}

extension TagCollectionViewCell: ProgrammaticallyInitializableViewProtocol {
    func addSubviews() {
        contentView.addSubview(textLabel)
    }
    
    func makeConstraints() {
        textLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(6)
            make.bottom.trailing.equalToSuperview().inset(6)
        }
    }
}
