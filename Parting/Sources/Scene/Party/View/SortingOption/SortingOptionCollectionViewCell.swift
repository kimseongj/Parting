//
//  SortingOptionCollectionViewCell.swift
//  Parting
//
//  Created by 김민규 on 2023/07/15.
//

import UIKit

class SortingOptionCollectionViewCell: UICollectionViewCell {
    
    private let cellConatiner: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.gray500
        view.clipsToBounds = true
        return view
    }()
    
    private let mainHStack = StackView(axis: .horizontal, alignment: .center, distribution: .equalCentering, spacing: 4)
    
    let textLabel = Label(text: "거리 순", weight: .Bold, size: 16, color: AppColor.white)
    
    let icon: UIImageView = {
        let image = UIImage(systemName: Images.sfSymbol.downChevron)
        let imageView = UIImageView(image: image)
        imageView.tintColor = AppColor.white
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        cellConatiner.layer.cornerRadius = cellConatiner.frame.height / 2
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SortingOptionCollectionViewCell: ProgrammaticallyInitializableViewProtocol {
    func addSubviews() {
        addSubview(cellConatiner)
        cellConatiner.addSubview(mainHStack)
        mainHStack.addArrangedSubview(textLabel)
        mainHStack.addArrangedSubview(icon)
        
    }
    
    func makeConstraints() {
        cellConatiner.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        mainHStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
//        icon.snp.makeConstraints { make in
//            make.width.equalTo(16)
//            make.height.equalTo(16)
//        }
        
    }
    

}

