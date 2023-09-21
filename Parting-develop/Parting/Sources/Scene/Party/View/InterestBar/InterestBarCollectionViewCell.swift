//
//  InterestBarCollectionViewCell.swift
//  Parting
//
//  Created by 김민규 on 2023/07/17.
//

import UIKit

class InterestBarCollectionViewCell: UICollectionViewCell {
    
//    static let identifier = "InterestBarCollectionViewCell"
    
    private var isActivated: Bool
    
    var getIsActivated: Bool {
        return isActivated
    }
    
    private let cellConatiner: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.layer.borderColor = AppColor.gray200.cgColor
        view.layer.borderWidth = 1.3
        return view
    }()
    
    let textLabel = Label(text: "스터디", weight: .Bold, size: 16, color: AppColor.gray200)
    
    override init(frame: CGRect) {
        isActivated = false
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
    
        cellConatiner.layer.cornerRadius = cellConatiner.frame.height / 3.7
        
    }
    
    
    public func setCellSelected(to: Bool) {
        if to {
            cellConatiner.layer.borderWidth = 0
            cellConatiner.backgroundColor = AppColor.brand
            textLabel.textColor = AppColor.white
        } else {
            cellConatiner.layer.borderWidth = 1.3
            cellConatiner.backgroundColor = .clear
            textLabel.textColor = AppColor.gray200
        }
        
        isActivated = to
    }
    
    func configureCell(with categoryDetail: CategoryDetail) {
        self.textLabel.text = categoryDetail.categoryDetailName
        
    }
    
}

extension InterestBarCollectionViewCell: ProgrammaticallyInitializableViewProtocol {
    func addSubviews() {
        addSubview(cellConatiner)
        cellConatiner.addSubview(textLabel)
    }
    
    func makeConstraints() {
        cellConatiner.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    
}

