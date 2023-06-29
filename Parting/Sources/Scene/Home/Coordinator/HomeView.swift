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
	lazy var bellButtonImageView: UIImageView = {
		let image = UIImage(systemName: Images.icon.bell)
		let imageView = UIImageView(image: image)
		return imageView
	}()
	
	lazy var bellButton: UIButton = {
		let button = UIButton()
		button.addSubview(bellButtonImageView)
		return button
	}()
	
	override func makeConfigures() {
		super.makeConfigures()
		
	}
	
	override func makeConstraints() {
		bellButtonImageView.snp.makeConstraints { make in
			make.center.equalTo(bellButton)
		}
		
	}
}


