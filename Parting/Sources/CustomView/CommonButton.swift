//
//  CommonButton.swift
//  Parting
//
//  Created by 박시현 on 2023/07/24.
//

import UIKit

class CompleteAndNextButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(AppColor.white, for: .normal)
        titleLabel?.font = notoSansFont.Bold.of(size: 20)
        layer.backgroundColor = AppColor.brand.cgColor
        layer.cornerRadius = 8
    }
    
    convenience init(_ title: String) {
        self.init()
        self.setTitle(title, for: .normal)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
