//
//  CreatePartyViewIntroLabel.swift
//  Parting
//
//  Created by 박시현 on 2023/07/24.
//

import UIKit

enum IntroLabelType {
    case maxSelectLabelNotiLabel
    case minAndMaxPeople
    case introContentsLabel
}

class IntroLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = notoSansFont.Black.of(size: 12)
        textColor = UIColor(hexcode: "D0D0D0")
    }
    
    convenience init(_ text: String, type: IntroLabelType) {
        self.init()
        self.text = text
        switch type {
        case .maxSelectLabelNotiLabel:
            self.textAlignment = .center
        case .minAndMaxPeople:
            self.textAlignment = .right
        case .introContentsLabel:
            self.textAlignment = .center
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
