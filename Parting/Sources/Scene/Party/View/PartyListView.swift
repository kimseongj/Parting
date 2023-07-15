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
		tableView.separatorStyle = .none
		tableView.showsVerticalScrollIndicator = false
		
		return tableView
	}()
	
	let fab: UIButton = {
		let button = UIButton()
		button.backgroundColor = AppColor.brand
		button.layer.cornerRadius = 32
		return button
	}()
	
	
	override func makeConfigures() {
		self.backgroundColor = .white
		
		addSubview(partyListTableView)
		addSubview(fab)
		
	}
	
	override func makeConstraints() {
		partyListTableView.snp.makeConstraints { make in
			make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
			make.left.equalToSuperview().offset(0)
			make.right.equalToSuperview().offset(-0)
			make.bottom.equalToSuperview()
		}
		
		fab.snp.makeConstraints { make in
			make.width.equalTo(64)
			make.height.equalTo(64)
			make.right.equalToSuperview().offset(-16)
			make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-16)
		}
		
	} /* End makeConstraints() */
	
}



