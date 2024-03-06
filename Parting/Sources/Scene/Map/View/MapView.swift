//
//  MapView.swift
//  Parting
//
//  Created by 박시현 on 2023/07/14.
//

import UIKit
import SnapKit
import NMapsMap

final class MapView: BaseView {
    let bellBarButton = BarImageButton(imageName: Images.sfSymbol.bell)
    
    let navigationLabel: BarTitleLabel = BarTitleLabel(text: "지도로 보기")
    
    let backBarButton = BarImageButton(imageName: Images.icon.back)
    
    let mapView: NMFNaverMapView = {
        let view = NMFNaverMapView()
        return view
    }()
    
    let partyInfoView = PartyInfoView()
    
    func hidePartyInfoView() {
        partyInfoView.isHidden = true
    }
    
    func presentInfoView() {
        partyInfoView.isHidden = false
        partyInfoView.tagCollectionView.reloadData()
    }
    
    override func makeConfigures() {
        super.makeConfigures()
        [mapView, partyInfoView].forEach{ self.addSubview($0)}
        hidePartyInfoView()
    }
    
    override func makeConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaInsets)
        }
        
        partyInfoView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
}

import RxCocoa

final class PartyInfoView: BaseView {
    private var tagList: [String] = []
    
    let locationImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        return label
    }()
    
    let headCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        label.backgroundColor = AppColor.brand
        label.layer.cornerRadius = 7
        label.clipsToBounds = true
        return label
    }()
    
    let partyImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let partyTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        return label
    }()
    
    let partyDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 11)
        return label
    }()
    
    let partyInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        label.numberOfLines = 2
        return label
    }()
    
    let tagCollectionView: MutableSizeCollectionView = {
        let leftAlignedCollectionViewFlowLayout = LeftAlignedCollectionViewFlowLayout()
        
        let collectionView = MutableSizeCollectionView(frame: .zero, collectionViewLayout: leftAlignedCollectionViewFlowLayout)
        collectionView.register(HashTagCollectionViewCell.self, forCellWithReuseIdentifier: HashTagCollectionViewCell.identifier)
        return collectionView
    }()
    
    func configureDetailCategoryCollectionView() {
        if let flowLayout = tagCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    func roundCorners() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 30
        self.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }
    
    func fill(with partyInfo: MarkerPartyInfo) {
        locationLabel.text = "\(partyInfo.address) \(partyInfo.distance)\(partyInfo.distanceUnit)"
        headCountLabel.text = "  \(partyInfo.currentPartyMemberCount) / \(partyInfo.maxPartyMemberCount)  "
        partyTitleLabel.text = partyInfo.partyName
        partyDateLabel.text = partyInfo.partyStartTime
        partyInfoLabel.text = partyInfo.description
        partyImageView.kf.setImage(with: URL(string: partyInfo.categoryImg))
        tagList = partyInfo.hashTagNameList
    }
    
    override func makeConfigures() {
        super.makeConfigures()
        [locationImageView, locationLabel, headCountLabel, partyImageView, partyTitleLabel, partyDateLabel, partyInfoLabel, tagCollectionView].forEach{ self.addSubview($0) }
    }
    
    override func makeConstraints() {
        roundCorners()
        configureDetailCategoryCollectionView()
        tagCollectionView.dataSource = self
        
        locationImageView.snp.makeConstraints {
            $0.centerY.equalTo(locationLabel)
            $0.leading.equalToSuperview().offset(22)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalTo(locationImageView.snp.trailing).offset(6)
        }
        
        headCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(locationLabel)
            $0.trailing.equalToSuperview().inset(22)
        }
        
        partyImageView.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(22)
            $0.size.equalTo(80)
        }
        
        partyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(partyImageView.snp.top)
            $0.leading.equalTo(partyImageView.snp.trailing).offset(13)
        }
        
        partyDateLabel.snp.makeConstraints {
            $0.top.equalTo(partyTitleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(partyTitleLabel.snp.leading)
        }
        
        partyInfoLabel.snp.makeConstraints {
            $0.top.equalTo(partyDateLabel.snp.bottom).offset(15)
            $0.leading.equalTo(partyTitleLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(22)
        }
        
        tagCollectionView.snp.makeConstraints {
            $0.top.equalTo(partyImageView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}

extension PartyInfoView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HashTagCollectionViewCell.identifier, for: indexPath) as? HashTagCollectionViewCell else { return UICollectionViewCell() }
        let tagName = tagList[indexPath.item]
        cell.configureCell(name: tagName)
        return cell
    }
}
