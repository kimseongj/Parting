//
//  customStackView.swift
//  Parting
//
//  Created by 박시현 on 2023/04/21.
//

import UIKit
import SnapKit

class essentialInfoStackView: UIStackView {
    let checkButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = AppColor.gray200.cgColor
        button.setImage(UIImage(named: "checkButton"), for: .normal)
        button.layer.borderWidth = 1
        return button
    }()

    let checkAnswerLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.gray200
        label.font = AppFont.Regular.of(size: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buttonConfigure()
        buttonConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buttonConstraints() {
        checkButton.snp.makeConstraints { make in
            make.width.height.equalTo(17)
//            make.height.equalToSuperview().multipliedBy(0.85)
//            make.width.equalTo(checkButton.snp.height)
        }
    }
    
    private func buttonConfigure() {
        [checkButton, checkAnswerLabel].forEach {
            self.addArrangedSubview($0)
        }
    }
    
    
}
