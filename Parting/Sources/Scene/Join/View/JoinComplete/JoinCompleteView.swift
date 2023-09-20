//
//  JoinCompleteView.swift
//  Parting
//
//  Created by 박시현 on 2023/04/20.
//

import UIKit
import SnapKit

class JoinCompleteView: BaseView {
    let completeLabel: UILabel = {
        let label = UILabel()
        label.text = "회원가입이 완료되었습니다!"
        label.font = AppleSDGothicNeoFont.Regular.of(size: 24)
        label.textAlignment = .center
        return label
    }()
    
    let writeInfoButton = CompleteAndNextButton("필수 정보 입력하기")
    
    override func makeConfigures() {
        super.makeConfigures()
        [completeLabel, writeInfoButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func makeConstraints() {
        completeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0.370 * UIScreen.main.bounds.height)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.04)
        }
        
        writeInfoButton.snp.makeConstraints { make in
            make.top.equalTo(completeLabel.snp.bottom).offset(0.038 * UIScreen.main.bounds.height)
            make.height.equalToSuperview().multipliedBy(0.0615)
            make.horizontalEdges.equalToSuperview().inset(22)
        }
    }
}
