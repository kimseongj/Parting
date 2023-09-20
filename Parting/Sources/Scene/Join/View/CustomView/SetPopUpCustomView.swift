//
//  SetPopUpCustomView.swift
//  Parting
//
//  Created by 박시현 on 2023/08/13.
//

import UIKit
import SnapKit

class SetPopUpCustomView: BaseView {
    let backgroundView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var popUpView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 7
        return view
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.alpha = 0.8
        return effectView
    }()
    
    let noButton: UIButton = {
        let button = UIButton()
        button.setTitle("아니오", for: .normal)
        button.setTitleColor(UIColor(hexcode: "9B9B9B"), for: .normal)
        return button
    }()
    
    let yesButton: UIButton = {
        let button = UIButton()
        button.setTitle("네", for: .normal)
        button.setTitleColor(UIColor(hexcode: "9B9B9B"), for: .normal)
        return button
    }()
    
    let alertText: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "해당 장소로 위치를 설정 하시겠습니까?"
        label.font = AppleSDGothicNeoFont.Bold.of(size: 18)
        return label
    }()
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override func makeConfigures() {
        buttonStackView.addArrangedSubview(noButton)
        buttonStackView.addArrangedSubview(yesButton)
        popUpView.addSubview(buttonStackView)
        popUpView.addSubview(alertText)
        backgroundView.addSubview(visualEffectView)
        self.addSubview(backgroundView)
        self.addSubview(popUpView)
    }
    
    override func makeConstraints() {
        visualEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        alertText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(24)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(alertText.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        popUpView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(14)
            make.height.equalToSuperview().multipliedBy(0.216)
            make.centerY.equalToSuperview()
        }
    }
}
