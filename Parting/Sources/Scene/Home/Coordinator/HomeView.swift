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
		view.alignment = .firstBaseline
		view.distribution = .equalSpacing
		view.backgroundColor = .white
		return view
	}()

	let scheduleStackView: UIStackView = {
		let view = StackView(axis: .horizontal, alignment: .leading, distribution: .equalSpacing, spacing: 20.0)
		return view
	}()
	
	let calendarWidget: UIButton = {
		let widget = CalendarWidgetView()
		return widget
	}()
	
	let dDayWidget: UIView = {
		let view = DdayWidgetView()
						  
		view.backgroundColor = .white
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
			make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(8)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		searchBar.snp.makeConstraints { make in
			make.right.equalToSuperview().offset(-8)
			make.left.equalToSuperview().offset(8)
		}
		
		scheduleStackView.snp.makeConstraints { make in
			make.left.equalToSuperview().offset(16)
			make.right.equalToSuperview().offset(-16)
		}
		
		let screenWidth = UIScreen.main.bounds.width
		let totalPadding = 32.0 + 20.0
		let widgetWidth = screenWidth - totalPadding
		let widgetWidthMultiplier = widgetWidth / screenWidth / 2

		calendarWidget.snp.makeConstraints { make in
			make.width.equalTo(snp.width).multipliedBy(widgetWidthMultiplier)
			make.height.equalTo(calendarWidget.snp.width)
		}

		dDayWidget.snp.makeConstraints { make in
			make.width.equalTo(snp.width).multipliedBy(widgetWidthMultiplier)
			make.height.equalTo(dDayWidget.snp.width)
		}
		
	}
}


