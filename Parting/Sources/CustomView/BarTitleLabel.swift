//
//  BarTitleLabel.swift
//  Parting
//
//  Created by 김민규 on 2023/07/01.
//

import Foundation
import UIKit

class BarTitleLabel: UILabel {
		
	override init(frame: CGRect) {
		super.init(frame: frame)
        font = AppFont.SemiBold.of(size: 20)
        textAlignment = .left
		textColor = AppColor.gray900
	}
	
	convenience init(text: String) {
		self.init()
		self.text = text
	}
	
    @available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
