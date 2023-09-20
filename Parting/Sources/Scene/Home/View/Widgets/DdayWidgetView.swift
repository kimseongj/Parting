//
//  DdayWidgetView.swift
//  Parting
//
//  Created by 김민규 on 2023/07/02.
//

import Foundation
import UIKit

class DdayWidgetView: UIView {
	
	private let vStack = StackView(axis: .vertical, alignment: .center, distribution: .equalCentering)
	
	public var dDay: Int = 0 {
		didSet {
			dDayLabel.text = "D-\(dDay)"
		}
	}
	
	public var meetingName: String = "OOO" {
		didSet {
			meetingLabel.text = "\(meetingName) 하는 모임"
		}
	}
	
	private let dDayLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Bold.of(size: 60)
		label.textColor = AppColor.brand
		label.text = "D-7"
		label.setContentHuggingPriority(.defaultHigh, for: .vertical)
		return label
	}()
	
	private let meetingLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Regular.of(size: 16)
		label.textColor = AppColor.brand
		
		label.text = "OOO 하는 모임"
		return label
	}()
	
	override init(frame: CGRect) {
		super .init(frame: frame)
		setupView()
		addSubviews()
		makeConstraints()
	}
	
	convenience init(dDay: Int, meetingName: String) {
		self.init()
		self.dDay = dDay
		self.meetingName = meetingName
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	

}

extension DdayWidgetView: ProgrammaticallyInitializableViewProtocol {
	func makeConstraints() {
		vStack.snp.makeConstraints { make in
			make.width.equalToSuperview()
			make.top.equalToSuperview().offset(20)
			make.bottom.equalToSuperview().offset(-20)
		}
	}
	
	func addSubviews() {
		addSubview(vStack)
		vStack.addArrangedSubview(meetingLabel)
		vStack.addArrangedSubview(dDayLabel)
	}
	
	func setupView() {
		layer.cornerRadius = 24.0
		layer.borderColor = AppColor.lightPink.cgColor
		layer.borderWidth = 1.2
	}
}
