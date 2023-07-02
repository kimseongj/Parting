//
//  CalendarWidget.swift
//  Parting
//
//  Created by 김민규 on 2023/06/29.
//

import UIKit
import SnapKit
import FSCalendar

class CalendarWidgetView: UIButton {
	
	fileprivate var calendar: FSCalendar
	
	override init(frame: CGRect) {
		calendar = FSCalendar(frame: .zero)
		super .init(frame: frame)
		setupView()
		
		setTitle("", for: .normal)
		addSubviews()
		makeConstraints()
		configureCalendar()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureCalendar() {
		calendar.isUserInteractionEnabled = false
		calendar.appearance.headerDateFormat = "M월"
		calendar.appearance.headerMinimumDissolvedAlpha = 0.0
		calendar.appearance.weekdayFont = .systemFont(ofSize: 0.0)
		calendar.appearance.todayColor = .clear
		calendar.appearance.headerTitleColor = AppColor.white
		calendar.appearance.headerTitleFont = notoSansFont.Medium.of(size: 16)
		calendar.weekdayHeight = 0.0
		calendar.appearance.titleDefaultColor = .white
		calendar.appearance.titleFont = notoSansFont.Regular.of(size: 12)
		calendar.placeholderType = .none
	}

}

extension CalendarWidgetView: ProgrammaticallyInitializableViewProtocol {
	func setupView() {
		backgroundColor = AppColor.lightPink
		layer.cornerRadius = 24.0
	}
	
	func makeConstraints() {
		calendar.snp.makeConstraints { make in
//			make.edges.equalToSuperview()
			make.top.equalToSuperview().offset(12)
			make.bottom.equalToSuperview().offset(-12)
			make.left.equalToSuperview().offset(12)
			make.right.equalToSuperview().offset(-12)
		}
	}
	
	func addSubviews() {
		addSubview(calendar)
	}
}
