//
//  TagCollectionViewCell.swift
//  Parting
//
//  Created by 김민규 on 2023/07/14.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    private let cellConatiner: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.gray200
        view.clipsToBounds = true
        return view
    }()
    
    let textLabel = Label(text: "#카공", weight: .Regular, size: 12)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellConatiner.layer.cornerRadius = cellConatiner.frame.height / 2
    }
    
    func configureCell(with text: String) {
        textLabel.text = text
    }
}

extension TagCollectionViewCell: ProgrammaticallyInitializableViewProtocol {
    func addSubviews() {
        contentView.addSubview(cellConatiner)
        cellConatiner.addSubview(textLabel)
    }
    
    func makeConstraints() {
        cellConatiner.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
