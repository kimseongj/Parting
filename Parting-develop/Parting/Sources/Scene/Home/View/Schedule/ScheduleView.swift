//
//  ScheduleView.swift
//  Parting
//
//  Created by 김민규 on 2023/07/01.
//

import Foundation
import UIKit
import SnapKit
import FSCalendar

class ScheduleView: BaseView {
	
	
	var bellBarButton = BarImageButton(imageName: Images.sfSymbol.bell)
	
	var backBarButton = BarImageButton(imageName: Images.icon.back)
	
	var titleView = BarTitleLabel(text: "일정 관리")
	
	private var calendar: FSCalendar!
	
	private func configureCalendar() {
		let width = UIScreen.main.bounds.width
		let height = UIScreen.main.bounds.height
		calendar = FSCalendar(frame: CGRect(x: 0.0, y: 100.0, width: width, height: height * 0.5))
		calendar.scrollDirection = .horizontal
		
		calendar.locale = Locale(identifier: "ko_KR")
		calendar.calendarHeaderView.backgroundColor = AppColor.brand
		calendar.calendarWeekdayView.backgroundColor = AppColor.brand
		calendar.appearance.headerDateFormat = "M월"
		calendar.appearance.headerMinimumDissolvedAlpha = 0.0
		
		calendar.appearance.weekdayTextColor = AppColor.white
		calendar.appearance.headerTitleColor = AppColor.white
		calendar.appearance.headerTitleFont = AppFont.Bold.of(size: 24)
		calendar.appearance.todayColor = AppColor.brand
		calendar.headerHeight = height * 0.08
		
		
		calendar.calendarWeekdayView.weekdayLabels[0].text = "Sun"
		calendar.calendarWeekdayView.weekdayLabels[1].text = "Mon"
		calendar.calendarWeekdayView.weekdayLabels[2].text = "Tue"
		calendar.calendarWeekdayView.weekdayLabels[3].text = "Wed"
		calendar.calendarWeekdayView.weekdayLabels[4].text = "Thu"
		calendar.calendarWeekdayView.weekdayLabels[5].text = "Fri"
		calendar.calendarWeekdayView.weekdayLabels[6].text = "Sat"
		
	}
	
	override func makeConfigures() {
		self.backgroundColor = .white
		
		configureCalendar()
		self.addSubview(calendar)
		
	}
	
	override func makeConstraints() {
		
		
	}
}



