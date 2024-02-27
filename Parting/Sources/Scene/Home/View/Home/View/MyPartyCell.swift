//
//  MyPartyCell.swift
//  Parting
//
//  Created by kimseongjun on 2/5/24.
//

import UIKit

final class MyPartyCell: UICollectionViewCell {
    private var hashTagList: [String] = []
    
    private let locationIcon: UIImageView = {
        let icon = UIImage(named: Images.icon.locationMarker)
        let imageView = UIImageView(image: icon)
        return imageView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 11)
        label.textColor = AppColor.gray500
        label.sizeToFit()
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Medium.of(size: 11)
        label.textColor = AppColor.white
        label.backgroundColor = AppColor.brand
        label.layer.cornerRadius = 7
        label.clipsToBounds = true
        return label
    }()
    
    private let partyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Medium.of(size: 16)
        label.textColor = AppColor.gray900
        return label
    }()
    
    private let periodLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Medium.of(size: 10)
        label.textColor = AppColor.gray400
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    private let partyDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)//AppFont.Regular.of(size: 12)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var tagCollectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeConfigures()
        makeConstraints()
        configureTagCollectionView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConfigures() {
        [locationIcon, locationLabel, statusLabel, partyImageView, titleLabel, periodLabel, partyDescriptionLabel, tagCollectionView].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        contentView.layer.cornerRadius = 10
        contentView.layer.borderColor = AppColor.gray100.cgColor
        contentView.layer.borderWidth = 1
        
        locationIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(12)
            $0.size.equalTo(14)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalTo(locationIcon.snp.trailing).offset(4)
        }
        
        statusLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().inset(12)
            $0.height.equalTo(15)
        }
        
        partyImageView.snp.makeConstraints {
            $0.top.equalTo(locationIcon.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(12)
            $0.size.equalTo(72)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(partyImageView.snp.top)
            $0.leading.equalTo(partyImageView.snp.trailing).offset(10)
        }
        
        periodLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(partyImageView.snp.trailing).offset(10)
        }
        
        partyDescriptionLabel.snp.makeConstraints {
            $0.bottom.equalTo(partyImageView.snp.bottom)
            $0.leading.equalTo(partyImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(12)
        }
        
        tagCollectionView.snp.makeConstraints {
            $0.top.equalTo(partyImageView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.height.equalTo(28)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
    
    func fill(with partyInfo: PartyInfoResponse) {
        locationLabel.text = partyInfo.address
        statusLabel.text = "  " + "\(partyInfo.currentPartyMemberCount) / \(partyInfo.maxPartyMemberCount)" + "  "
        partyImageView.kf.setImage(with: URL(string: partyInfo.categoryImg))
        titleLabel.text = partyInfo.partyName
        periodLabel.text = partyInfo.partyStartTime
        partyDescriptionLabel.text = partyInfo.description
        tagCollectionView.reloadData()
    }
    
    private func configureTagCollectionView() {
        tagCollectionView.dataSource = self
        
        if let flowLayout = tagCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
}

extension MyPartyCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hashTagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
        cell.fill(with: hashTagList[indexPath.row])
        return cell
    }
}
