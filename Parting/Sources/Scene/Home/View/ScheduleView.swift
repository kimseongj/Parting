//
//  ScheduleView.swift
//  Parting
//
//  Created by 김민규 on 2023/07/01.
//

import Foundation
import UIKit
import SnapKit

class ScheduleView: BaseView {

	
	var bellBarButton = BarImageButton(imageName: Images.icon.bell)
	
	var backBarButton = BarImageButton(imageName: Images.icon.back)
	
	var titleView = BarTitleLabel(text: "일정 관리")
	
	
	override func makeConfigures() {
		self.backgroundColor = .white
		

	}
	
	override func makeConstraints() {

	
	}
}



