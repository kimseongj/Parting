//
//  LoginButton.swift
//  Parting
//
//  Created by 박시현 on 2023/07/25.
//

import UIKit

enum LoginType {
    case kakao
    case apple
    
    var title: String {
        switch self {
        case .kakao:
            return "카카오 로그인"
        case .apple:
            return "Apple로 로그인"
        }
    }
    
    var logoImage: String {
        switch self {
        case .kakao:
            return "KakaoLogin"
        case .apple:
            return "AppleLogin"
        }
    }
    
    var backgroundColor: CGColor {
        switch self {
        case .kakao:
            return AppColor.kakaoButton.cgColor
        case .apple:
            return AppColor.white.cgColor
        }
    }
}

class LoginButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 8
        titleLabel?.font = AppFont.Regular.of(size: 16)
        setTitleColor(AppColor.baseText, for: .normal)
        imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width * 0.457)
    }
    
    convenience init(type: LoginType) {
        self.init()
        switch type {
        case .kakao:
            layer.backgroundColor = LoginType.kakao.backgroundColor
            setTitle(LoginType.kakao.title, for: .normal)
            setImage(UIImage(named: LoginType.kakao.logoImage), for: .normal)
        case .apple:
            layer.backgroundColor = LoginType.apple.backgroundColor
            setTitle(LoginType.apple.title, for: .normal)
            setImage(UIImage(named: LoginType.apple.logoImage), for: .normal)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
