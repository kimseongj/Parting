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
    
    var text: String {
        switch self {
        case .maxSelectLabelNotiLabel:
            return "최대 2개까지 중복 선택이 가능합니다."
        case .minAndMaxPeople:
            return "본인 포함 최소3명, 최대 20명"
        case .introContentsLabel:
            return "파티에서 어떤 활동을 하는지 소개해 주세요."
        }
    }
}

class IntroLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = notoSansFont.Black.of(size: 12)
        textColor = UIColor(hexcode: "D0D0D0")
    }
    
    convenience init(type: IntroLabelType) {
        self.init()
        switch type {
        case .maxSelectLabelNotiLabel:
            self.text = IntroLabelType.maxSelectLabelNotiLabel.text
            self.textAlignment = .center
        case .minAndMaxPeople:
            self.text = IntroLabelType.minAndMaxPeople.text
            self.textAlignment = .right
        case .introContentsLabel:
            self.text = IntroLabelType.introContentsLabel.text
            self.textAlignment = .center
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
