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
	
	fileprivate var fsCalendar: FSCalendar
    private var partyDay: [Int] = []
	override init(frame: CGRect) {
		fsCalendar = FSCalendar(frame: .zero)
		super .init(frame: frame)
		setupView()
        fsCalendar.delegate = self
		setTitle("", for: .normal)
		addSubviews()
		makeConstraints()
		configureCalendar()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    
	private func configureCalendar() {
		fsCalendar.isUserInteractionEnabled = false
		fsCalendar.appearance.headerDateFormat = "M월"
		fsCalendar.appearance.headerMinimumDissolvedAlpha = 0.0
		fsCalendar.appearance.weekdayFont = .systemFont(ofSize: 0.0)
		fsCalendar.appearance.todayColor = .clear
		fsCalendar.appearance.headerTitleColor = AppColor.white
		fsCalendar.appearance.headerTitleFont = notoSansFont.Medium.of(size: 16)
		fsCalendar.weekdayHeight = 0.0
		fsCalendar.appearance.titleDefaultColor = .white
		fsCalendar.appearance.titleFont = notoSansFont.Regular.of(size: 12)
		fsCalendar.placeholderType = .none
	}
}

extension CalendarWidgetView: ProgrammaticallyInitializableViewProtocol {
	func setupView() {
		backgroundColor = AppColor.lightPink
		layer.cornerRadius = 24.0
	}
	
	func makeConstraints() {
		fsCalendar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
			make.bottom.equalToSuperview().offset(-12)
			make.left.equalToSuperview().offset(12)
			make.right.equalToSuperview().offset(-12)
		}
	}
	
	func addSubviews() {
		addSubview(fsCalendar)
	}
    
    func receiveCalendarDays(calendarDays: [Int]) {
        partyDay = calendarDays
        fsCalendar.reloadData()
        print(partyDay, "💜💜")
    }
}
extension CalendarWidgetView: FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        
        if partyDay.contains(day) {
            return AppColor.brand // 5일, 7일, 9일에 대한 색상을 원하는 색상으로 변경
        }
        return nil
    }
}

extension CalendarWidgetView: FSCalendarDataSource {
    
}
