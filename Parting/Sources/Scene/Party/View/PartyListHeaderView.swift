//
//  PartyListHeaderView.swift
//  Parting
//
//  Created by 김민규 on 2023/07/15.
//

import UIKit

class PartyListHeaderView: UITableViewHeaderFooterView {
	
	static let identifier = "PartyListHeaderView"
	
	private let interestCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		return collectionView
	}()
	
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		setupView()
		addSubviews()
		makeConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

extension PartyListHeaderView: ProgrammaticallyInitializableViewProtocol {
	func setupView() {
		self.backgroundColor = AppColor.white
	}
	
	func addSubviews() {
		
	}
	
	func makeConstraints() {
		
	}
}
