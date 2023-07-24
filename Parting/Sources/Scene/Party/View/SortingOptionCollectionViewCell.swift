//
//  SortingOptionCollectionViewCell.swift
//  Parting
//
//  Created by 김민규 on 2023/07/15.
//

import UIKit

class SortingOptionCollectionViewCell: UICollectionViewCell {
    
	static let identifier = "SortingOptionCollectionViewCell"
	
	private let cellConatiner: UIView = {
		let view = UIView()
		view.backgroundColor = AppColor.gray500
		view.clipsToBounds = true
		return view
	}()
	
	private let textLabel = Label(text: "거리 순", weight: .Bold, size: 16, color: AppColor.white)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubviews()
		makeConstraints()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
	
		cellConatiner.layer.cornerRadius = cellConatiner.frame.height / 2
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

extension SortingOptionCollectionViewCell: ProgrammaticallyInitializableViewProtocol {
	func addSubviews() {
		addSubview(cellConatiner)
		cellConatiner.addSubview(textLabel)
	}
	
	func makeConstraints() {
		cellConatiner.snp.makeConstraints { make in
			make.height.equalTo(32)
			make.width.equalToSuperview()
			make.centerY.equalToSuperview()
		}
		
		textLabel.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
	}
	

}
