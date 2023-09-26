//
//  InquireView.swift
//  Parting
//
//  Created by 이병현 on 2023/09/26.
//

import UIKit
import SnapKit

final class InquireView: BaseView {
    var backBarButton = BarImageButton(imageName: Images.icon.back)
    let navigationLabel: BarTitleLabel = BarTitleLabel(text: "프로필 수정")
    
    let emailTitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 16)
        label.textColor = UIColor(hexcode: "404040")
        label.text = "이메일을 입력해주세요"
        return label
    }()
    
    let emailTextFieldContainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexcode: "F8FAFD")
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "example@naver.com"
        return textField
    }()
    
    let inquireTitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 16)
        label.textColor = UIColor(hexcode: "404040")
        label.text = "문의 내용을 입력해주세요"
        return label
    }()
    
    let inquireTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = UIColor(hexcode: "F8FAFD")
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
        view.layer.borderWidth = 1
        view.textColor = .lightGray
        view.text = "내용을 입력하세요"
        return view
    }()
    
    let textCountLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 14)
        label.textColor = AppColor.gray400
        label.textAlignment = .right
        label.text = "0/1000"
        return label
    }()
    
    let infoCheckButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        button.tintColor = AppColor.gray100
        return button
    }()
    
    let infoTitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 16)
        label.textColor = UIColor(hexcode: "404040")
        label.text = "이메일 정보 제공 동의"
        return label
    }()
    
    let infoSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 12)
        label.textColor = AppColor.gray400
        label.text = "질문에 답변드리기 위해 이메일 정보 제공에 동의해주세요"
        return label
    }()
    
    let finishButton = CompleteAndNextButton("완료")

    override func makeConfigures() {
        super.makeConfigures()
        
        self.addSubview(finishButton)
        self.addSubview(emailTitleLabel)
        self.addSubview(emailTextFieldContainView)
        self.addSubview(emailTextField)
        self.addSubview(inquireTitleLabel)
        self.addSubview(infoCheckButton)
        self.addSubview(infoTitleLabel)
        self.addSubview(infoSubtitleLabel)
        self.addSubview(inquireTextView)
        self.addSubview(textCountLabel)
    }
    
    override func makeConstraints() {
        
        finishButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(50)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-39)
        }
        
        emailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(28)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(19)
        }
        
        emailTextFieldContainView.snp.makeConstraints { make in
            make.top.equalTo(emailTitleLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(36)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(emailTextFieldContainView).inset(14)
            make.verticalEdges.equalTo(emailTextFieldContainView)
        }
        
        inquireTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextFieldContainView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(19)
        }
        
        infoCheckButton.snp.makeConstraints { make in
            make.bottom.equalTo(finishButton.snp.top).offset(-84)
            make.leading.equalTo(safeAreaLayoutGuide).offset(24)
            make.height.width.equalTo(19)
        }
        
        infoTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(infoCheckButton.snp.top)
            make.leading.equalTo(infoCheckButton.snp.trailing).offset(12)
            make.height.equalTo(19)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-24)
        }
        
        infoSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(infoTitleLabel.snp.bottom).offset(4)
            make.leading.equalTo(infoCheckButton.snp.trailing).offset(12)
            make.height.equalTo(19)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-24)
        }
        
        inquireTextView.snp.makeConstraints { make in
            make.top.equalTo(emailTextFieldContainView.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        inquireTextView.snp.makeConstraints { make in
            make.top.equalTo(inquireTextView.snp.bottom).offset(12)
            make.bottom.equalTo(infoTitleLabel.snp.top).offset(-19)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        textCountLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(inquireTextView).inset(10)
            make.bottom.equalTo(inquireTextView.snp.bottom).offset(-10)
            make.height.equalTo(17)
        }
    }
}

extension InquireView {
    func updateTextCountLabel(text: String) {
        if inquireTextView.text == "내용을 입력하세요" {
            textCountLabel.text = "0/1000"
        } else {
            textCountLabel.text = "\(text.count)/1000"
        }
    }
    
    func checkButtonValid(checkOn: Bool) {
        switch checkOn {
        case true:
            infoCheckButton.tintColor = AppColor.brand
        case false:
            infoCheckButton.tintColor = AppColor.gray100
        }
    }
    
    func finishButtonValid(valid: Bool) {
        switch valid {
        case true:
            finishButton.layer.backgroundColor = AppColor.brand.cgColor
            finishButton.isEnabled = true
        case false:
            finishButton.layer.backgroundColor = AppColor.brandNotValidate.cgColor
            finishButton.isEnabled = false
        }
    }
}
