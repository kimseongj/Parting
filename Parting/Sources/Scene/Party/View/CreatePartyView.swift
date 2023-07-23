//
//  CreatePartyView.swift
//  Parting
//
//  Created by 김민규 on 2023/07/17.
//

import Foundation
import UIKit
import SnapKit

class CreatePartyView: BaseView {

	
	let navigationLabel = BarTitleLabel(text: "파티 생성")
	
	var backBarButton = BarImageButton(imageName: Images.icon.back)
	
	let mainStackView: UIStackView = {
		let view = StackView(axis: .vertical, alignment: .firstBaseline, distribution: .equalSpacing, spacing: 8.0)
		view.backgroundColor = .white
		return view
	}()

	let categoryCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.isScrollEnabled = false
		return collectionView
	}()
	
	override func makeConfigures() {
		self.backgroundColor = .white
		
		addSubview(mainStackView)

		
		mainStackView.addArrangedSubview(categoryCollectionView)
	}
	
	override func makeConstraints() {

		mainStackView.snp.makeConstraints { make in
			make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(8)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}

	
		
		let screenWidth = UIScreen.main.bounds.width
		let totalPadding = 32.0 + 20.0
		let widgetWidth = screenWidth - totalPadding
		let widgetWidthMultiplier = widgetWidth / screenWidth / 2



		categoryCollectionView.snp.makeConstraints { make in
			make.left.equalToSuperview().offset(16)
			make.right.equalToSuperview().offset(-16)
			make.height.equalTo(UIScreen.main.bounds.height * 0.25)
		}
		
	}
	
}
