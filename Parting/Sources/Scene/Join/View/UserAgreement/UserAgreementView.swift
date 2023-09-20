//
//  UserAgreementView.swift
//  Parting
//
//  Created by 박시현 on 2023/09/20.
//

import UIKit
import SnapKit

class UserAgreementView: BaseView {
    let userAgreementTitleLabel: UILabel = {
        let label = UILabel()
        label.text = """
이용 약관에
동의해주세요
"""
        label.numberOfLines = 2
        label.sizeToFit()
        label.font = AppFont.Medium.of(size: 22)
        return label
    }()
    
    let serviceConditionLabel: UILabel = {
        let label = UILabel()
        label.text = "서비스 이용 약관"
        label.font = AppFont
        return label
    }()
    
    
    override func makeConfigures() {
        [userAgreementTitleLabel].forEach {
            addSubview($0)
        }
    }
    
    override func makeConstraints() {
        userAgreementTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).inset(24)
            make.width.equalTo(115)
        }
    }
}
