//
//  RadioButton.swift
//  Parting
//
//  Created by 박시현 on 2023/08/17.
//

import UIKit

class RadioButton: UIButton {
    
    
    private let imageForNormal = UIImage(systemName: Images.sfSymbol.circle)
    private let imageForSelected = UIImage(systemName: Images.sfSymbol.filledRadio)
    
    var isChecked: Bool {
        didSet {
            if isChecked == true {
                self.setImage(imageForSelected, for: .normal)
            } else {
                self.setImage(imageForNormal, for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        self.isChecked = false
        super.init(frame: frame)
        self.setImage(imageForNormal, for: .normal)
        self.setTitle("기본 텍스트", for: .normal)
        self.setTitleColor(AppColor.baseText, for: .normal)
        self.setTitleColor(AppColor.baseText, for: .highlighted)
        self.titleLabel?.font = notoSansFont.Medium.of(size: 16)
        self.tintColor = AppColor.brand
        var config = UIButton.Configuration.plain()
        config.imagePadding = 8
        self.configuration = config
    }
    
    convenience init(text: String, weight: notoSansFont, textSize: CGFloat) {
        self.init()
        self.setTitle(text, for: .normal)
//        self.addTarget(self, action:#selector(buttonTapped(sender:)), for: .touchUpInside)
        self.titleLabel?.font = weight.of(size: textSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func buttonTapped(sender: UIButton) {

        if sender == self {
            isChecked = !isChecked
        }
    
    }
}
