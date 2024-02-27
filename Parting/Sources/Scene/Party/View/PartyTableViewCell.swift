//
//  PartyTableViewCell.swift
//  Parting
//
//  Created by 김민규 on 2023/07/11.
//

import UIKit

class PartyTableViewCell: UITableViewCell {
    private var hashTagList: [String] = []
    
    // MARK: Top Stack Components
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
        label.clipsToBounds = true
        return label
    }()
    
    private let partyImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
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
    
    // MARK: init
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        addSubviews()
        configureTagCollectionView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 10
        contentView.layer.borderColor = AppColor.gray100.cgColor
        contentView.layer.borderWidth = 1
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
        makeConstraints()
        DispatchQueue.main.async {
            self.statusLabel.layer.cornerRadius = 7
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureMyPageCell(party: PartyInfoResponse) {
        locationLabel.text = party.address
        partyImage.kf.setImage(with: URL(string: party.categoryImg))
        titleLabel.text = party.partyName
        periodLabel.text = party.partyEndTime
        statusLabel.text = "   \(party.currentPartyMemberCount)/\(party.maxPartyMemberCount)   "
        partyDescriptionLabel.text = party.description
    }
    
    func fill(with party: PartyListItemModel) {
        locationLabel.text = party.location
        partyImage.kf.setImage(with: URL(string: party.imgURL))
        titleLabel.text = party.title
        periodLabel.text = party.partyDuration
        statusLabel.text = "   \(party.currentPartyMemberCount)/\(party.maxPartyMemberCount)   "
        statusLabel.sizeToFit()
        partyDescriptionLabel.text = party.description
        hashTagList = party.tags
        tagCollectionView.reloadData()
    }
    
    func configureTagCollectionView() {
        tagCollectionView.dataSource = self
        
        if let flowLayout = tagCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
}

// MARK: ProgrammaticallyInitializableViewProtocol
extension PartyTableViewCell: ProgrammaticallyInitializableViewProtocol {
    func addSubviews() {
        [locationIcon, locationLabel, statusLabel, partyImage, titleLabel, periodLabel, partyDescriptionLabel, tagCollectionView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func makeConstraints() {
        locationIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(12)
            make.height.equalTo(14)
            make.width.equalTo(14)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalTo(locationIcon.snp.trailing).offset(4)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(15)
        }
        
        partyImage.snp.makeConstraints { make in
            make.top.equalTo(locationIcon.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(12)
            make.width.equalTo(72)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(partyImage.snp.trailing).offset(10)
            make.top.equalTo(locationIcon.snp.bottom).offset(12)
        }
        
        periodLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(partyImage.snp.trailing).offset(10)
        }
        
        partyDescriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(partyImage.snp.bottom)
            make.leading.equalTo(partyImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(12)
        }
        
        tagCollectionView.snp.makeConstraints { make in
            make.top.equalTo(partyImage.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(30)
            make.bottom.equalToSuperview().inset(12)
        }
    }
}

extension PartyTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hashTagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
        cell.fill(with: hashTagList[indexPath.row])
        return cell
    }
}
