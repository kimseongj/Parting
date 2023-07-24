//
//  Label.swift
//  Parting
//
//  Created by 김민규 on 2023/07/14.
//

import UIKit

class Label: UILabel {

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.textColor = AppColor.baseText
	}
	
	convenience init(text: String, font: UIFont) {
		self.init()
		self.text = text
		self.font = font
	}
	
	convenience init(text: String, font: UIFont, color: UIColor) {
		self.init()
		self.text = text
		self.font = font
		self.textColor = color
	}

	convenience init(text: String, weight: notoSansFont, size: CGFloat) {
		self.init()
		self.text = text
		self.font = weight.of(size: size)
	}

	convenience init(text: String, weight: notoSansFont, size: CGFloat, color: UIColor) {
		self.init()
		self.text = text
		self.font = weight.of(size: size)
		self.textColor = color
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
