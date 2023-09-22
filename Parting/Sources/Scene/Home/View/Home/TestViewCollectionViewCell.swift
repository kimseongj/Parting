//
//  TestViewCollectionViewCell.swift
//  Parting
//
//  Created by 박시현 on 2023/09/22.
//

import UIKit
import SnapKit
final class TestViewCollectionViewCell: UICollectionViewCell {
    let partyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let partyImageBGView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = AppColor.gray50.cgColor
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        return view
    }()
    
    let partyTitle: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 12)
        label.textColor = AppColor.gray700
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeConfigures()
        makeConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(item: PartyList) {
        partyImageView.image = UIImage(named: item.imageNameList)
        partyTitle.text = item.imageNameList
    }
    
    func makeConfigures() {
        partyImageBGView.addSubview(partyImageView)
        [partyImageBGView, partyTitle].forEach {
            contentView.addSubview($0)
        }
    }
    
    func makeConstraints() {
        partyImageBGView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.width.equalTo(partyImageBGView.snp.height)
            make.centerX.equalToSuperview()
        }
        
        partyImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(9)
        }
        
        partyTitle.snp.makeConstraints { make in
            make.top.equalTo(partyImageBGView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
