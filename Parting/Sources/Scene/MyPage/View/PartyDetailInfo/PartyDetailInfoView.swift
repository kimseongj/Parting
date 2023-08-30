//
//  PartyDetailInfoView.swift
//  Parting
//
//  Created by 박시현 on 2023/08/30.
//

import UIKit
import SnapKit
import Kingfisher

class PartyDetailInfoView: BaseView {
    let testImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    let contentsView: UIView = {
        let view = UIView()
        return view
    }()
    
    let bellBarButton = BarImageButton(imageName: Images.sfSymbol.bell)
    let navigationLabel = BarTitleLabel(text: "상세 정보")
    let backBarButton = BarImageButton(imageName: Images.icon.back)
    
    let partyTitle: UILabel = {
        let label = UILabel()
        label.font = notoSansFont.Bold.of(size: 20)
        label.text = "OO하는 모임"
        return label
    }()
    
    
    let partyPersonnel: UILabel = {
        let label = UILabel()
        label.text = "2/5"
        label.backgroundColor = AppColor.brand
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = notoSansFont.Medium.of(size: 11)
        label.textColor = AppColor.white
        return label
    }()
    
    let reportOrshareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "reportAndShare"), for: .normal)
        return button
    }()
    
    let categoryImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    // MARK: - Cell 생성해주어야 함
    let partyTypeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize.width = 63
        layout.itemSize.height = 23
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    // MARK: - Cell 생성해주어야 함
    let hashTagCategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize.height = 18
        layout.itemSize.width = 70
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    let deadLineLabel: UILabel = {
        let label = UILabel()
        label.text = "11월 11일 PM. 1:00 모집 마감"
        label.layer.borderColor = AppColor.brand.cgColor
        label.layer.cornerRadius = 8
        label.textColor = AppColor.brand
        label.textAlignment = .center
        label.layer.borderWidth = 3
        label.font = notoSansFont.Bold.of(size: 20)
        return label
    }()
    
    let partyPersonnelBackgroundView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let partyPersonnelLabel: UILabel = {
        let label = UILabel()
        label.text = "파티 인원"
        label.font = notoSansFont.Medium.of(size: 12)
        label.textColor = UIColor(hexcode: "BABABA")
        return label
    }()
    
    // MARK: - Cell 생성해주어야 함
    let partyPersonnelCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize.width = 30
        layout.itemSize.height = 50
        layout.minimumLineSpacing = 25
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    let partyInfoBackgroundView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let partyInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "파티 정보"
        label.font = notoSansFont.Medium.of(size: 12)
        label.textColor = UIColor(hexcode: "BABABA")
        return label
    }()
    
    let ageGroupImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "person")
        return image
    }()
    
    let ageGroupLabel: UILabel = {
        let label = UILabel()
        label.text = "22세 ~ 26세"
        label.font = notoSansFont.Medium.of(size: 12)
        return label
    }()
    
    let ageGroupView: UIView = {
        let view = UIView()
        return view
    }()
    
    let partyPeriodImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "calendar")
        return image
    }()
    
    let partyPeriodLabel: UILabel = {
        let label = UILabel()
        label.text = "2022.11.11 ~ 13시 ~ 15시"
        label.font = notoSansFont.Medium.of(size: 12)
        return label
    }()
    
    let partyPeriodView: UIView = {
        let view = UIView()
        return view
    }()
    
    let locationImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "location")
        return image
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "대구 산격동 140"
        label.font = notoSansFont.Medium.of(size: 12)
        return label
    }()
    
    let locationView: UIView = {
        let view = UIView()
        return view
    }()
    
    let descriptionPartyBackgroundView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let descriptionPartyLabel: UILabel = {
        let label = UILabel()
        label.text = "파티 정보"
        label.font = notoSansFont.Medium.of(size: 12)
        label.textColor = UIColor(hexcode: "BABABA")
        return label
    }()
    
    let descriptionPartyContentsLabel: UILabel = {
        let label = UILabel()
        label.text = "같이 열심히 공부합시다!"
        label.font = notoSansFont.Medium.of(size: 12)
        return label
    }()
    
    let leavePartyButton = CompleteAndNextButton("파티 나가기")
    
    override func layoutSubviews() {
        configureViews()
    }
    
    override func makeConfigures() {
        super.makeConfigures()
        [ageGroupImage, ageGroupLabel].forEach {
            ageGroupView.addSubview($0)
        }
        
        [partyPeriodImage, partyPeriodLabel].forEach {
            partyPeriodView.addSubview($0)
        }
        
        [locationImage, locationLabel].forEach {
            locationView.addSubview($0)
        }
        
        [partyInfoLabel, ageGroupView, partyPeriodView, locationView].forEach {
            partyInfoBackgroundView.addSubview($0)
        }
        
        [partyPersonnelLabel,  partyPersonnelCollectionView].forEach {
            partyPersonnelBackgroundView.addSubview($0)
        }
        
        [descriptionPartyLabel, descriptionPartyContentsLabel].forEach {
            descriptionPartyBackgroundView.addSubview($0)
        }
        
        [testImageView, partyTitle, partyPersonnel, reportOrshareButton, categoryImage, partyTypeCollectionView, hashTagCategoryCollectionView, deadLineLabel, partyPersonnelBackgroundView, partyInfoBackgroundView, descriptionPartyBackgroundView, leavePartyButton].forEach {
            contentsView.addSubview($0)
        }
        
        scrollView.addSubview(contentsView)
        addSubview(scrollView)
    }
    
    override func makeConstraints() {
        testImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(300)
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentsView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.greaterThanOrEqualTo(self.snp.height).priority(.low)
        }
        
        partyTitle.snp.makeConstraints { make in
            make.top.equalTo(testImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(23)
        }
        
        partyPersonnel.snp.makeConstraints { make in
            make.top.equalTo(testImageView.snp.bottom).offset(10)
            make.leading.equalTo(partyTitle.snp.trailing).offset(9)
            make.width.equalTo(47)
            make.height.equalTo(26)
        }
        
        reportOrshareButton.snp.makeConstraints { make in
            make.top.equalTo(testImageView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        }
        
        categoryImage.snp.makeConstraints { make in
            make.top.equalTo(partyTitle.snp.bottom).offset(14)
            make.leading.equalToSuperview().inset(23)
            make.width.height.equalTo(25)
        }
        
        partyTypeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(partyTitle.snp.bottom).offset(14)
            make.leading.equalTo(categoryImage.snp.trailing).offset(18)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(25)
        }
        
        hashTagCategoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(partyTypeCollectionView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(25)
        }
        
        deadLineLabel.snp.makeConstraints { make in
            make.top.equalTo(hashTagCategoryCollectionView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        partyPersonnelBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(deadLineLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(85)
        }
        
        partyPersonnelLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.height.equalTo(19)
        }
        
        partyPersonnelCollectionView.snp.makeConstraints { make in
            make.top.equalTo(partyPersonnelLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
        partyInfoBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(partyPersonnelBackgroundView.snp.bottom).offset(14)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(118)
        }
        
        partyInfoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.height.equalTo(24)
        }
        
        ageGroupImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.height.equalTo(15)
        }
        
        ageGroupLabel.snp.makeConstraints { make in
            make.leading.equalTo(ageGroupImage.snp.trailing).offset(7)
            make.top.trailing.equalToSuperview()
            make.height.equalTo(15)
        }
        
        ageGroupView.snp.makeConstraints { make in
            make.top.equalTo(partyInfoLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        
        partyPeriodImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.height.equalTo(15)
        }
        
        partyPeriodLabel.snp.makeConstraints { make in
            make.leading.equalTo(ageGroupImage.snp.trailing).offset(7)
            make.top.trailing.equalToSuperview()
            make.height.equalTo(15)
        }
        
        partyPeriodView.snp.makeConstraints { make in
            make.top.equalTo(ageGroupView.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        
        locationImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.height.equalTo(15)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.leading.equalTo(ageGroupImage.snp.trailing).offset(7)
            make.top.trailing.equalToSuperview()
            make.height.equalTo(15)
        }
        
        locationView.snp.makeConstraints { make in
            make.top.equalTo(partyPeriodView.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        
        descriptionPartyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.height.equalTo(24)
        }
        
        descriptionPartyContentsLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionPartyLabel.snp.bottom).offset(7)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        
        descriptionPartyBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(partyInfoBackgroundView.snp.bottom).offset(14)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(85)
        }
        
        leavePartyButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionPartyBackgroundView.snp.bottom).offset(23)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(40)
        }
    }
}

extension PartyDetailInfoView {
    func configureViews() {
        categoryImage.kf.setImage(with: URL(string: "https://parting-dev.s3.ap-northeast-2.amazonaws.com/categoryImage/%EC%9E%90%EA%B8%B0%EA%B0%9C%EB%B0%9C%ED%8C%9F.png"))
    }
}
