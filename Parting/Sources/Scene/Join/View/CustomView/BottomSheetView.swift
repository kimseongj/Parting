//
//  BottomSheetView.swift
//  Parting
//
//  Created by 박시현 on 2023/07/19.
//

import UIKit
import SnapKit
import Kingfisher

class BottomSheetView: BaseView {
    let locationLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 12)
        label.textColor = AppColor.gray500
        label.sizeToFit()
        return label
    }()
    
    let pageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = AppColor.brand
        label.font = AppFont.Medium.of(size: 12)
        label.textColor = AppColor.white
        label.textAlignment = .center
        label.clipsToBounds = true
        return label
    }()
    
    let centerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let partyImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 5.5
        return view
    }()
    
    let partyNameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Medium.of(size: 18)
        label.textColor = AppColor.gray900
        label.sizeToFit()
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Medium.of(size: 11)
        label.textColor = AppColor.gray400
        label.sizeToFit()
        return label
    }()
    
    let partyDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 13)
        label.textColor = AppColor.gray700
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    let testCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize.height = 18
        layout.itemSize.width = 120
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()

    
    let lineLabel: UILabel = {
        let label = UILabel()
        label.layer.borderWidth = 1
        label.layer.borderColor = AppColor.gray50.cgColor
        return label
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("닫기", for: .normal)
        button.titleLabel?.font = AppFont.Medium.of(size: 18)
        button.setTitleColor(AppColor.gray700, for: .normal)
        return button
    }()
    
    func configureView(model: AroundPartyDetailResponse) {
        locationLabel.text = model.result.partyInfos[0].address
        pageLabel.text = "\(model.result.partyInfos[0].currentPartyMemberCount)/\(model.result.partyInfos[0].maxPartyMemberCount)"
        partyImageView.kf.setImage(with: URL(string: model.result.partyInfos[0].categoryImg))
        partyNameLabel.text = model.result.partyInfos[0].partyName
        dateLabel.text = "\(model.result.partyInfos[0].partyStartTime) ~ \(model.result.partyInfos[0].partyEndTime)" 
        partyDescriptionLabel.text = model.result.partyInfos[0].description
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pageLabel.layer.cornerRadius = pageLabel.frame.height / 2
    }
    
    override func makeConfigures() {
        super.makeConfigures()
        [partyImageView, partyNameLabel, dateLabel, partyDescriptionLabel].forEach {
            centerView.addSubview($0)
        }
        
        [locationLabel, pageLabel, centerView, testCollectionView, lineLabel, closeButton].forEach {
            addSubview($0)
        }
    }
    
    override func makeConstraints() {
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(18)
            make.leading.equalTo(30)
            make.height.equalTo(26)
        }
        
        pageLabel.snp.makeConstraints { make in
            make.top.equalTo(18)
            make.trailing.equalToSuperview().inset(24)
            make.width.equalTo(47)
            make.height.equalTo(26)
        }
        
        partyImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.size.equalTo(80)
        }
        
        partyNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(partyImageView.snp.trailing).offset(8)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(partyNameLabel.snp.bottom)
            make.leading.equalTo(partyImageView.snp.trailing).offset(8)
        }
        
        partyDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(6)
            make.leading.equalTo(partyImageView.snp.trailing).offset(8)
        }
        
        centerView.snp.makeConstraints { make in
            make.top.equalTo(pageLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(108)
        }
        
        testCollectionView.snp.makeConstraints { make in
            make.top.equalTo(partyImageView.snp.bottom).offset(9)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(30)
        }
        
        lineLabel.snp.makeConstraints { make in
            make.top.equalTo(testCollectionView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(lineLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(38)
            make.height.equalTo(33)
        }
    }
}
