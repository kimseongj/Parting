//
//  HomeView.swift
//  Parting
//
//  Created by 김민규 on 2023/05/09.
//

import Foundation
import UIKit
import SnapKit

class HomeView: BaseView {

	let bellBarButton = BarImageButton(imageName: Images.icon.bell)
	
	let searchBar: UISearchBar = {
		let bar = UISearchBar()
		bar.placeholder = "세부 카테고리 검색"
		bar.backgroundImage = UIImage()
		return bar
	}()
	
	let navigationLabel = BarTitleLabel(text: "팟팅")
	
	let mainStackView: UIStackView = {
		let view = UIStackView()
		view.axis = .vertical
		view.alignment = .center
		view.backgroundColor = .clear
		return view
	}()
	
	let scheduleStackView: UIStackView = {
		let view = StackView(axis: .horizontal, alignment: .fill)
		view.backgroundColor = .systemGreen
		return view
	}()
	
	let calendarWidget: UIButton = {
		let button = UIButton()
		button.setTitle("test", for: .normal)
		button.backgroundColor = .magenta
		return button
	}()
	
	let dDayWidget: UIView = {
		let view = UIView()
		view.backgroundColor = .brown
		return view
	}()
	
	override func makeConfigures() {
		self.backgroundColor = .white
		
		addSubview(mainStackView)
		mainStackView.addArrangedSubview(searchBar)
		mainStackView.addArrangedSubview(scheduleStackView)
		scheduleStackView.addArrangedSubview(calendarWidget)
		scheduleStackView.addArrangedSubview(dDayWidget)
	}
	
	override func makeConstraints() {
		
		mainStackView.snp.makeConstraints { make in
			make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(8)
//			make.bottom.equalToSuperview()
			make.width.equalToSuperview()
		}
		
		searchBar.snp.makeConstraints { make in
			make.right.equalToSuperview().offset(-8)
			make.left.equalToSuperview().offset(8)
		}
		
		scheduleStackView.snp.makeConstraints { make in
			make.left.equalToSuperview().offset(16)
			make.right.equalToSuperview().offset(-16)
		}

		calendarWidget.snp.makeConstraints { make in
			make.width.equalTo(snp.width).multipliedBy(0.4)
			make.height.equalTo(calendarWidget.snp.width)
		}

		dDayWidget.snp.makeConstraints { make in
			make.width.equalTo(snp.width).multipliedBy(0.4)
			make.height.equalTo(calendarWidget.snp.width)
		}
	}
}


