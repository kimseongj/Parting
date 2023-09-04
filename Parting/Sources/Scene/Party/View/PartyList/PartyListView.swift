//
//  PartyListView.swift
//  Parting
//
//  Created by 김민규 on 2023/07/11.
//

import UIKit
import SnapKit

class PartyListView: BaseView {

	let bellBarButton = BarImageButton(imageName: Images.sfSymbol.bell)
	
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
	
	private let fabSymbol: UIImageView = {
		let config = UIImage.SymbolConfiguration(scale: .large)
		let image = UIImage(systemName: Images.sfSymbol.plus, withConfiguration: config)
		let imageView = UIImageView(image: image)
		imageView.isUserInteractionEnabled = false
		imageView.tintColor = AppColor.white
		return imageView
	}()
	
	
	override func makeConfigures() {
//        super.makeConfigures()
		self.backgroundColor = .white
		
		addSubview(partyListTableView)
		addSubview(fab)
		fab.addSubview(fabSymbol)
		
	}
	
	override func makeConstraints() {
		partyListTableView.snp.makeConstraints { make in
			make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview().inset(16)
			make.bottom.equalToSuperview()
		}
		
		fab.snp.makeConstraints { make in
			make.width.equalTo(64)
			make.height.equalTo(64)
			make.right.equalToSuperview().offset(-16)
			make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-16)
		}
		
		fabSymbol.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
		
	} /* End makeConstraints() */
	
}



