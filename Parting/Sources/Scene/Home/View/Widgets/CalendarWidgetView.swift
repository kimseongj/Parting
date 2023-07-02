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
	
	override init(frame: CGRect) {
		super .init(frame: frame)
		setupView()
		setTitle("Widget", for: .normal)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
//		print(self.bounds.width)
	}

}

extension CalendarWidgetView: ProgrammaticallyInitializableViewProtocol {
	func setupView() {
		backgroundColor = AppColor.lightPink
		layer.cornerRadius = 24.0
	}
	
	func makeConstraints() {
		
	}
	
	func addSubviews() {
		
	}
}
