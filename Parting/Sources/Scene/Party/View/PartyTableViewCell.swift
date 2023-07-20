//
//  PartyTableViewCell.swift
//  Parting
//
//  Created by 김민규 on 2023/07/11.
//

import UIKit

class PartyTableViewCell: UITableViewCell {
	
	static let identifier = "PartyTableViewCell"
	
	private let cellContainer: UIStackView = {
		let view = StackView(axis: .vertical, alignment: .center, distribution: .equalCentering)
		view.layer.cornerRadius = 16
		view.layer.shadowColor = AppColor.baseText.cgColor
		view.layer.shadowOpacity = 0.1
		view.layer.shadowRadius = 16
		view.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
		view.layer.shadowPath = nil
		view.backgroundColor = .white
		return view
	}()
	
	// MARK: Cell Components
	private let mainVStack = StackView(axis: .vertical, alignment: .firstBaseline, distribution: .equalSpacing, spacing: 12.0)

	private let topHStack = StackView(axis: .horizontal, alignment: .center, distribution: .fill, spacing: 16.0)
	
	private let contentHStack = StackView(axis: .horizontal, alignment: .center, distribution: .equalCentering, spacing: 32.0)
	
	private let tagCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = .clear
		return collectionView
	}()
	
	
	// MARK: Top Stack Components
	private let locationIcon: UIImageView = {
		let icon = UIImage(named: Images.icon.locationMarker)
		let imageView = UIImageView(image: icon)
		return imageView
	}()
	
	private let locationLabel = Label(text: "대한민국 어딘가", weight: .Light, size: 16)
	
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
	private let contentVStack = StackView(axis: .vertical, alignment: .leading, distribution: .fill, spacing: 4.0)
	
	private let thumbnail: UIImageView = {
		let imageView = UIImageView()
		let url = URL(string: "https://picsum.photos/200/300")
		imageView.kf.setImage(with: url)
		imageView.layer.cornerRadius = 16
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private let titleLabel = Label(text: "파티 이름", font: notoSansFont.Bold.of(size: 20))
	
	private let periodLabel = Label(text: "2023. 1. 1 - 1시 ~ 2시", font: notoSansFont.Regular.of(size: 16))
	
	private let detailLabel = Label(text: "같이 공부합시다", font: notoSansFont.Regular.of(size: 16), color: AppColor.gray600)
	
	// MARK: init
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupView()
		addSubviews()
		
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		makeConstraints()
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}

// MARK: ProgrammaticallyInitializableViewProtocol
extension PartyTableViewCell: ProgrammaticallyInitializableViewProtocol {
	func setupView() {
		backgroundColor = AppColor.white
		configureCollectionView()
	}
	
	func addSubviews() {
		addSubview(cellContainer)
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
		contentVStack.addArrangedSubview(detailLabel)
		contentVStack.setCustomSpacing(0.0, after: titleLabel)
		
	}
	
	func makeConstraints() {
		let cellHeight = self.frame.height
		
		cellContainer.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(16)
			make.bottom.equalToSuperview().offset(-16)
			make.left.equalToSuperview().offset(16)
			make.right.equalToSuperview().offset(-16)
		}
		
		mainVStack.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(16)
			make.bottom.equalToSuperview().offset(-16)
			make.left.equalToSuperview().offset(16)
			make.right.equalToSuperview().offset(-16)
		}
		
		topHStack.snp.makeConstraints { make in
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.height.equalTo(24)
		}
		
		locationIcon.snp.makeConstraints { make in
			make.height.equalTo(16)
			make.width.equalTo(16)
		}
		
		statusLabel.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.centerY.equalToSuperview().offset(-1)
		}
		
		contentHStack.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview()
//			make.height.equalTo(cellHeight * 0.43)
		}
		
		tagCollectionView.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview()
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
		
		contentVStack.snp.makeConstraints { make in
			make.height.equalToSuperview()
		}
	}
	
}

// MARK: Collection View
extension PartyTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
	
	func configureCollectionView() {
		tagCollectionView.delegate = self
		tagCollectionView.dataSource = self
		tagCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = tagCollectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell
		else { return UICollectionViewCell() }
		
		return cell
	}
	
	
}
