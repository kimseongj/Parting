//
//  PartyListView.swift
//  Parting
//
//  Created by 김민규 on 2023/07/11.
//

import Foundation
import UIKit
import SnapKit

class PartyListView: BaseView {

	let bellBarButton = BarImageButton(imageName: Images.icon.bell)
	
	let navigationLabel = BarTitleLabel(text: "무슨무슨팟")
	
	var backBarButton = BarImageButton(imageName: Images.icon.back)
	
	let partyListTableView: UITableView = {
		let tableView = UITableView()
		return tableView
	}()
	
	
	override func makeConfigures() {
		self.backgroundColor = .white
		
	}
	
	override func makeConstraints() {

	} /* End makeConstraints() */
	
}



