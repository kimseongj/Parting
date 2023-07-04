//
//  JoinView.swift
//  Parting
//
//  Created by 박시현 on 2023/04/17.
//

import UIKit
import SnapKit

class JoinView: BaseView {
    let backGroundView: SplashView = {
        let view = SplashView()
        return view
    }()
    
    let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.layer.backgroundColor = AppColor.kakaoButton.cgColor
        button.layer.cornerRadius = 8
        button.setTitle("카카오 로그인", for: .normal)
        button.titleLabel?.font = notoSansFont.Regular.of(size: 16)
        button.setTitleColor(AppColor.baseText, for: .normal)
        button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width * 0.457)
        button.setImage(UIImage(named: "KakaoLogin"), for: .normal)
        return button
    }()
    
    let appleLoginButton: UIButton = {
        let button = UIButton()
        button.layer.backgroundColor = AppColor.white.cgColor
        button.layer.cornerRadius = 8
        button.setTitle("Apple로 로그인", for: .normal)
        button.titleLabel?.font = notoSansFont.Regular.of(size: 16)
        button.setTitleColor(AppColor.baseText, for: .normal)
        button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width * 0.457)
        button.setImage(UIImage(named: "AppleLogin"), for: .normal)
        return button
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.white
        label.text = "간편하게 로그인하고 서비스를 이용해보세요"
        label.textAlignment = .center
        label.font = notoSansFont.Regular.of(size: 13)
        return label
    }()
    
    override func makeConfigures() {
        [backGroundView, kakaoLoginButton, appleLoginButton, loginLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func makeConstraints() {
        backGroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.size.height * 0.665)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalToSuperview().multipliedBy(Double(50)/Double(701))
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.top.equalTo(kakaoLoginButton.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalToSuperview().multipliedBy(Double(50)/Double(701))
        }
        
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(appleLoginButton.snp.bottom).offset(15.69)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(Double(24)/Double(701))
        }
    }
}
