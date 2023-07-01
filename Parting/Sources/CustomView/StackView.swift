//
//  StackView.swift
//  Parting
//
//  Created by 김민규 on 2023/06/30.
//

import UIKit

class StackView: UIStackView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		
	}
	
	convenience init(axis:  NSLayoutConstraint.Axis, alignment: UIStackView.Alignment) {
		self.init()
		self.axis = axis
		self.alignment = alignment
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
