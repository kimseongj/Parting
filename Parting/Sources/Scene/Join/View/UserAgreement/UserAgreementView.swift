//
//  UserAgreementView.swift
//  Parting
//
//  Created by 박시현 on 2023/09/20.
//

import UIKit
import SnapKit

enum ButtonType {
    case serviceAgreement
    case personalInfoAgreement
    case nextButton
}

class UserAgreementView: BaseView {
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        label.font = AppFont.Medium.of(size: 15)
        label.textColor = AppColor.gray700
        label.sizeToFit()
        return label
    }()
    
    let serviceConditionTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = UIColor(hexcode: "F8FAFD")
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let serviceAgreeButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = AppColor.gray200.cgColor
        button.setImage(UIImage(named: "checkButton"), for: .normal)
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        return button
    }()
    
    let serviceAgreeButtonLabel: UILabel = {
        let label = UILabel()
        label.text = "이용약관 동의(필수)"
        label.font = AppFont.SemiBold.of(size: 16)
        label.textColor = AppColor.gray900
        return label
    }()
    
    let serviceButtonView: UIView = {
        let view = UIView()
        return view
    }()
    
    let personalInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "개인정보 처리 방침"
        label.font = AppFont.Medium.of(size: 15)
        label.textColor = AppColor.gray700
        label.sizeToFit()
        return label
    }()
    
    let personalInfoTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = UIColor(hexcode: "F8FAFD")
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let personalInfoButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = AppColor.gray200.cgColor
        button.setImage(UIImage(named: "checkButton"), for: .normal)
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        return button
    }()
    
    let personalInfoButtonLabel: UILabel = {
        let label = UILabel()
        label.text = "개인정보 수집 이용 동의(필수)"
        label.font = AppFont.SemiBold.of(size: 16)
        label.textColor = AppColor.gray900
        return label
    }()
    
    let personalInfoButtonView: UIView = {
        let view = UIView()
        return view
    }()
    
    let nextStepButton = CompleteAndNextButton("다음")
    
    func changeButtonColor(buttonType: ButtonType, state: Bool) {
        switch buttonType {
        case .nextButton:
            if state {
                nextStepButton.backgroundColor = AppColor.brand
            } else {
                nextStepButton.backgroundColor = AppColor.brandNotValidate
            }
        case .serviceAgreement:
            if state {
                serviceAgreeButton.backgroundColor = AppColor.brand
                serviceAgreeButton.setImage(UIImage(named: "clickedCheckButton"), for: .normal)
                serviceAgreeButton.layer.borderWidth = 0
            } else {
                serviceAgreeButton.layer.borderColor = AppColor.gray200.cgColor
                serviceAgreeButton.setImage(UIImage(named: "checkButton"), for: .normal)
                serviceAgreeButton.backgroundColor = .white
            }
        case .personalInfoAgreement:
            if state {
                personalInfoButton.backgroundColor = AppColor.brand
                personalInfoButton.setImage(UIImage(named: "clickedCheckButton"), for: .normal)
                personalInfoButton.layer.borderWidth = 0
            } else {
                personalInfoButton.layer.borderColor  = AppColor.gray200.cgColor
                personalInfoButton.setImage(UIImage(named: "checkButton"), for: .normal)
                personalInfoButton.backgroundColor = AppColor.white
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        serviceAgreeButton.layer.cornerRadius = serviceAgreeButton.frame.height / 2
        personalInfoButton.layer.cornerRadius = personalInfoButton.frame.height / 2
    }
    
    override func makeConfigures() {
        super.makeConfigures()
        [serviceAgreeButton, serviceAgreeButtonLabel].forEach {
            serviceButtonView.addSubview($0)
        }
        
        [personalInfoButton, personalInfoButtonLabel].forEach {
            personalInfoButtonView.addSubview($0)
        }
        
        [userAgreementTitleLabel, serviceConditionLabel, serviceConditionTextView, serviceButtonView, personalInfoLabel, personalInfoTextView, personalInfoButtonView, nextStepButton].forEach {
            contentView.addSubview($0)
        }
        
        scrollView.addSubview(contentView)
        addSubview(scrollView)
    }
    
    override func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.height.greaterThanOrEqualTo(self.snp.height).priority(.low)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        serviceAgreeButton.snp.makeConstraints { make in
            make.width.height.equalTo(19)
            make.leading.top.equalToSuperview()
        }
        
        serviceAgreeButtonLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(serviceAgreeButton.snp.trailing).offset(11)
        }
        
        personalInfoButton.snp.makeConstraints { make in
            make.width.height.equalTo(19)
            make.leading.top.equalToSuperview()
        }
        
        personalInfoButtonLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(personalInfoButton.snp.trailing).offset(11)
        }
        
        userAgreementTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(safeAreaLayoutGuide).inset(24)
            make.width.equalTo(115)
        }
        
        serviceConditionLabel.snp.makeConstraints { make in
            make.top.equalTo(userAgreementTitleLabel.snp.bottom).offset(21)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        serviceConditionTextView.snp.makeConstraints { make in
            make.top.equalTo(serviceConditionLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(209)
        }
        
        serviceButtonView.snp.makeConstraints { make in
            make.top.equalTo(serviceConditionTextView.snp.bottom).offset(14)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(20)
        }
        
        personalInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(serviceButtonView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        personalInfoTextView.snp.makeConstraints { make in
            make.top.equalTo(personalInfoLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(209)
        }
        
        personalInfoButtonView.snp.makeConstraints { make in
            make.top.equalTo(personalInfoTextView.snp.bottom).offset(14)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(20)
        }
        
        nextStepButton.snp.makeConstraints { make in
            make.top.equalTo(personalInfoButtonView.snp.bottom).offset(36
            )
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalToSuperview().multipliedBy(0.061)
            make.bottom.equalToSuperview().inset(38)
        }
    }
}
