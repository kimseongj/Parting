//
//  PartyTableViewCell.swift
//  Parting
//
//  Created by 김민규 on 2023/07/11.
//

import UIKit

class PartyTableViewCell: UITableViewCell {

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
        label.text = "대구 중구 1km"
        label.sizeToFit()
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Medium.of(size: 11)
        label.textColor = AppColor.white
        label.backgroundColor = AppColor.brand
        label.clipsToBounds = true
        label.textAlignment = .center
        label.text = "2/5"
        return label
    }()
    
    private let centerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let partyImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 5
        view.image = UIImage(systemName: "person")
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Medium.of(size: 16)
        label.textColor = AppColor.gray900
        label.text = "공무원 스터디"
        return label
    }()
    
    private let periodLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Medium.of(size: 10)
        label.textColor = AppColor.gray400
        label.numberOfLines = 0
        label.text = "2022년 11월 11일 13시 ~ 15시"
        label.sizeToFit()
        return label
    }()
    
    private let partyDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.gray700
        label.font = AppFont.Regular.of(size: 12)
        return label
    }()
    
    private let tagCollectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 10
        contentView.layer.borderColor = AppColor.gray100.cgColor
        contentView.layer.borderWidth = 1
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
        makeConstraints()
        DispatchQueue.main.async {
            self.statusLabel.layer.cornerRadius = self.statusLabel.frame.height / 2
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
        statusLabel.text = "\(party.currentPartyMemberCount)/\(party.maxPartyMemberCount)"
        partyDescriptionLabel.text = party.description
    }
}

// MARK: ProgrammaticallyInitializableViewProtocol
extension PartyTableViewCell: ProgrammaticallyInitializableViewProtocol {
    func addSubviews() {
        [partyImage, titleLabel, periodLabel, partyDescriptionLabel].forEach {
            centerView.addSubview($0)
        }
        
        [locationIcon, locationLabel, statusLabel, centerView, tagCollectionView].forEach {
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
            make.width.equalTo(34)
        }
        
        centerView.snp.makeConstraints { make in
            make.top.equalTo(locationIcon.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(80)
        }
        
        partyImage.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(4)
            make.size.equalTo(72)
                
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(partyImage.snp.trailing).offset(10)
            make.top.equalToSuperview().inset(4)
        }
        
        periodLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(partyImage.snp.trailing).offset(10)

        }
        
        partyDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(periodLabel.snp.bottom).offset(4)
            make.leading.equalTo(partyImage.snp.trailing).offset(10)
            make.bottom.equalToSuperview()

        }
        
        tagCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(14)
            make.height.equalTo(24)
        }
        
    }
    
}

// MARK: Collection View
//extension PartyTableViewCell: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PartyT, for: <#T##IndexPath#>)
//    }
    
//}

