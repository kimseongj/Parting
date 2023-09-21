//
//  JoinNavigationBar.swift
//  Parting
//
//  Created by 박시현 on 2023/07/24.
//

import UIKit

enum NaviPostion {
    case JoinComplete
    case EssentialInfo
    case Interests
    case DetailInterests
    
    var title: String {
        switch self {
        case .JoinComplete, .Interests, .DetailInterests:
            return "관심사를 설정해주세요"
        case .EssentialInfo:
            return "필수 정보 입력"
        }
    }
}

class JoinNavigationBar: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = AppColor.joinText
        textAlignment = .center
        font = AppFont.Regular.of(size: 20)
        sizeToFit()
    }
    
    convenience init(type: NaviPostion) {
        self.init()
        switch type {
        case .JoinComplete, .Interests, .DetailInterests:
            self.text = NaviPostion.JoinComplete.title
        case .EssentialInfo:
            self.text = NaviPostion.EssentialInfo.title
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
