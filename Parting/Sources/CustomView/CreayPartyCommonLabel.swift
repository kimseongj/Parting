//
//  CreayPartyCommonLabel.swift
//  Parting
//
//  Created by 박시현 on 2023/07/22.
//

import UIKit

class CreatePartyCommonLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = AppleSDGothicNeoFont.Medium.of(size: 15)
        textAlignment = .center
        textColor = AppColor.brand
        clipsToBounds = true
        layer.cornerRadius = 12
        layer.borderColor = AppColor.brand.cgColor
        layer.borderWidth = 1
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
