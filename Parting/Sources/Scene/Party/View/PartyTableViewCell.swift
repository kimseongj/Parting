//
//  PartyTableViewCell.swift
//  Parting
//
//  Created by 김민규 on 2023/07/11.
//

import UIKit

class PartyTableViewCell: UITableViewCell {
    
//    static let identifier = "PartyTableViewCell"
    
    private var tagTexts: [String] = []
    var testId: Int?
    private let cellContainer: UIStackView = {
        let view = StackView(axis: .vertical, alignment: .center, distribution: .equalCentering)
        view.layer.cornerRadius = 16
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: Cell Components
    private let mainVStack = StackView(axis: .vertical, alignment: .firstBaseline, distribution: .equalSpacing, spacing: 12.0)
    
    private let topHStack = StackView(axis: .horizontal, alignment: .center, distribution: .fill, spacing: 16.0)
    
    private let contentHStack = StackView(axis: .horizontal, alignment: .center, distribution: .equalCentering, spacing: 32.0)
    
    private let tagCollectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.itemSize.height = 18
        layout.itemSize.width = 150
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    
    // MARK: Top Stack Components
    private let locationIcon: UIImageView = {
        let icon = UIImage(named: Images.icon.locationMarker)
        let imageView = UIImageView(image: icon)
        return imageView
    }()
    
    private let locationLabel = Label(text: "대한민국 어딘가", weight: .Light, size: 15)
    
    private let locationHStack = StackView(axis: .horizontal, alignment: .center, distribution: .equalSpacing, spacing: 8.0)
    
    private let spacerView = UIView()
    
    private let statusView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.brand
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let statusLabel = Label(text: "2/5", weight: .Regular, size: 16, color: AppColor.white)
    
    
    // MARK: Content Stack Components
    private let contentVStack = StackView(axis: .vertical, alignment: .leading, distribution: .fillProportionally, spacing: 4.0)
    
    private let thumbnail: UIImageView = {
        let imageView = UIImageView()
        let url = URL(string: "https://picsum.photos/200/300")
        imageView.kf.setImage(with: url)
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel = Label(text: "파티 이름", font: notoSansFont.Bold.of(size: 13))
    
    private let periodLabel: UILabel = {
        let label = Label(text: "2023. 1. 1 - 1시 ~ 2시", font: notoSansFont.Regular.of(size: 15))
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    //    private let detailLabel = Label(text: "같이 공부합시다", font: notoSansFont.Regular.of(size: 16), color: AppColor.gray600)
    
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
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 13, right: 0))
        makeConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(party: PartyListItemModel) {
        locationLabel.text = party.location + " " + party.distance
        titleLabel.text = party.title
        periodLabel.text = party.partyDuration
        statusLabel.text = "\(party.currentPartyMemberCount)/\(party.maxPartyMemberCount)"
        tagTexts = party.tags
        DispatchQueue.main.async { [weak self] in
            self?.tagCollectionView.collectionViewLayout.invalidateLayout()
        }
        
        guard let url = URL(string: party.imgURL) else { return }
        
        thumbnail.kf.setImage(with: url)
    }
    
    func configureMyPageCell(party: PartyInfoResponse) {
        print(party.address, "💛")
        locationLabel.text = party.address + " " + "\(party.distance)"
        titleLabel.text = party.partyName
        periodLabel.text = party.partyStartTime + party.partyEndTime
        statusLabel.text = "\(party.currentPartyMemberCount)/\(party.maxPartyMemberCount)"
        tagTexts = party.hashTagNameList
        
        guard let url = URL(string: party.categoryImg) else { return }
        
        thumbnail.kf.setImage(with: url)
    }
    
    
}

// MARK: ProgrammaticallyInitializableViewProtocol
extension PartyTableViewCell: ProgrammaticallyInitializableViewProtocol {
    func setupView() {
        backgroundColor = AppColor.white
        configureCollectionView()
    }
    
    func addSubviews() {
        contentView.addSubview(cellContainer)
        cellContainer.addSubview(mainVStack)
        mainVStack.addArrangedSubview(topHStack)
        mainVStack.addArrangedSubview(contentHStack)
        mainVStack.addArrangedSubview(tagCollectionView)
        
        topHStack.addArrangedSubview(locationHStack)
        topHStack.addArrangedSubview(spacerView)
        topHStack.addArrangedSubview(statusView)
        locationHStack.addArrangedSubview(locationIcon)
        locationHStack.addArrangedSubview(locationLabel)
        statusView.addSubview(statusLabel)
        
        
        contentHStack.addArrangedSubview(thumbnail)
        contentHStack.addArrangedSubview(contentVStack)
        
        contentVStack.addArrangedSubview(titleLabel)
        contentVStack.addArrangedSubview(periodLabel)
        //        contentVStack.addArrangedSubview(detailLabel)
        contentVStack.setCustomSpacing(0.0, after: titleLabel)
        
    }
    
    func makeConstraints() {
        let cellHeight = self.frame.height
        
        cellContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
//            make.top.equalToSuperview().offset(16)
//            make.bottom.equalToSuperview().offset(-16)
//            make.left.equalToSuperview().offset(16)
//            make.right.equalToSuperview().offset(-16)
        }
        
        mainVStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
//            make.top.equalToSuperview().offset(16)
//            make.bottom.equalToSuperview().offset(-16)
//            make.left.equalToSuperview().offset(16)
//            make.right.equalToSuperview().offset(-16)
        }
        
        topHStack.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(14)
            make.height.equalTo(24)
        }
        
        locationIcon.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
        
        periodLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        statusLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-1)
        }
        
        contentHStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(14)
            make.trailing.equalToSuperview()
        }
        
        tagCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(14)
            make.height.equalTo(24)
        }
        
        statusView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(52)
        }
        
        thumbnail.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(thumbnail.snp.height)
        }
    }
    
}

// MARK: Collection View
extension PartyTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func configureCollectionView() {
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagTexts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = tagCollectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell
        else { return UICollectionViewCell() }

        
        if indexPath[1] < tagTexts.count {
            cell.configureCell(with: tagTexts[indexPath[1]])
        }
        
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cell = collectionView.cellForItem(at: indexPath) as? TagCollectionViewCell
        let text = cell?.textLabel.text ?? "세글자"
        let width = text.size(withAttributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12)
        ]).width + 20
        return CGSize(width: width, height: self.frame.height / 2)
        
        
        
    } /* End sizeForItemAt */
    

}

