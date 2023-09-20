//
//  EssentialInfoView.swift
//  Parting
//
//  Created by 박시현 on 2023/04/20.
//

import UIKit
import SnapKit

class EssentialInfoView: BaseView {
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    // MARK: - 스크롤뷰 내부에 들어갈 Content View
    // UI 컴포넌트들이 contentView에 들어가야함
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let EssentialInfoTitle: UILabel = {
        let label = UILabel()
        label.text = """
필수 정보를
입력해주세요
"""
        label.numberOfLines = 2
        label.sizeToFit()
        label.font = AppleSDGothicNeoFont.Medium.of(size: 22)
        return label
    }()
    
    let jobLabel: UILabel = {
        let label = UILabel()
        label.text = "직업이 있으신가요?"
        label.sizeToFit()
        label.font = AppleSDGothicNeoFont.Regular.of(size: 16)
        return label
    }()
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "성별을 입력해주세요"
        label.sizeToFit()
        label.font = AppleSDGothicNeoFont.Regular.of(size: 16)
        return label
    }()
    
    /// 직업 학생 버튼
    let checkJobFirstStackView: essentialInfoStackView = {
        let view = essentialInfoStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 11
        return view
    }()
    
    /// 직업 직장인 버튼
    let checkJobSecondStackView: essentialInfoStackView = {
        let view = essentialInfoStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 11
        return view
    }()
    
    /// 성별 남자 버튼
    let checkGenderFirstStackView: essentialInfoStackView = {
        let view = essentialInfoStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 11
        return view
    }()
    
    /// 성별 여자 버튼
    let checkGenderSecondStackView: essentialInfoStackView = {
        let view = essentialInfoStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 11
        return view
    }()
    
    let birthLabel: UILabel = {
        let label = UILabel()
        label.text = "생년월일을 입력해주세요"
        label.sizeToFit()
        label.font = AppleSDGothicNeoFont.Regular.of(size: 16)
        return label
    }()
    
    let yearTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(hexcode: "F8FAFD")
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = AppColor.gray200.cgColor
        textField.font = AppleSDGothicNeoFont.Regular.of(size: 13)
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        return textField
    }()
    
    let yearLiteralLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexcode: "A7B0C0")
        label.text = "년"
        label.font = AppleSDGothicNeoFont.Regular.of(size: 13)
        return label
    }()
    
    let yearStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 6
        return view
    }()
    
    let monthTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(hexcode: "F8FAFD")
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = AppColor.gray200.cgColor
        textField.layer.borderWidth = 1
        textField.font = AppleSDGothicNeoFont.Regular.of(size: 13)
        textField.textAlignment = .center
        return textField
    }()
    
    let monthLiteralLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexcode: "A7B0C0")
        label.text = "월"
        label.font = AppleSDGothicNeoFont.Regular.of(size: 13)
        return label
    }()
    
    let monthStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 6
        return view
    }()
    
    let dayTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(hexcode: "F8FAFD")
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = AppColor.gray200.cgColor
        textField.layer.borderWidth = 1
        textField.font = AppleSDGothicNeoFont.Regular.of(size: 13)
        textField.textAlignment = .center
        return textField
    }()
    
    let dayLiteralLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexcode: "A7B0C0")
        label.text = "일"
        label.font = AppleSDGothicNeoFont.Regular.of(size: 13)
        return label
    }()
    
    let dayStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 6
        return view
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = AppleSDGothicNeoFont.Regular.of(size: 16)
        label.text = "주소를 입력해주세요"
        label.sizeToFit()
        return label
    }()
    
    let sidoTextField: UITextField = {
        let textField = UITextField()
        textField.font = AppleSDGothicNeoFont.Regular.of(size: 13)
        textField.attributedPlaceholder = NSAttributedString(string: "시도 선택", attributes: [.foregroundColor: AppColor.gray200, .font: AppleSDGothicNeoFont.Regular.of(size: 13)])
        textField.backgroundColor = UIColor(hexcode: "F8FAFD")
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = AppColor.gray200.cgColor
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        return textField
    }()
    
    let sigugunTextField: UITextField = {
        let textField = UITextField()
        textField.font = AppleSDGothicNeoFont.Regular.of(size: 13)
        textField.attributedPlaceholder = NSAttributedString(string: "시군구 선택", attributes: [.foregroundColor: AppColor.gray200, .font: AppleSDGothicNeoFont.Regular.of(size: 13)])
        textField.backgroundColor = UIColor(hexcode: "F8FAFD")
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = AppColor.gray200.cgColor
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        return textField
    }()
    
    let addressStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillProportionally
        return view
    }()
    
    let nickNameLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = AppleSDGothicNeoFont.Regular.of(size: 11)
        label.textColor = AppColor.gray500
        label.text = "앱 이용 시 나의 프로필 이름으로 표시됩니다"
        return label
    }()
    
    let nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = AppleSDGothicNeoFont.Regular.of(size: 13)
        textField.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [.foregroundColor: AppColor.gray200, .font: AppleSDGothicNeoFont.Regular.of(size: 13)])
        textField.backgroundColor = UIColor(hexcode: "F8FAFD")
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = AppColor.gray200.cgColor
        textField.layer.borderWidth = 1
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        return textField
    }()
    
    let nickNameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임을 입력해주세요"
        label.sizeToFit()
        label.font = AppleSDGothicNeoFont.Regular.of(size: 16)
        return label
    }()
    
    /// 닉네임 중복확인 버튼
    let duplicatedNickNameCheckButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(hexcode: "F8FAFD")
        button.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = AppleSDGothicNeoFont.Regular.of(size: 13)
        button.setTitle("중복확인", for: .normal)
        button.setTitleColor(UIColor(hexcode: "A7B0C0"), for: .normal)
        return button
    }()
    
    let nickNameStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillProportionally
        return view
    }()
    
    let nextStepButton = CompleteAndNextButton("다음 단계로")
    
    override func makeConfigures() {
        super.makeConfigures()
        [yearTextField,yearLiteralLabel].forEach {
            yearStackView.addArrangedSubview($0)
        }
        
        [monthTextField, monthLiteralLabel].forEach {
            monthStackView.addArrangedSubview($0)
        }
        
        [dayTextField, dayLiteralLabel].forEach {
            dayStackView.addArrangedSubview($0)
        }
        
        [sidoTextField, sigugunTextField].forEach {
            addressStackView.addArrangedSubview($0)
        }
        
        [nickNameTextField, duplicatedNickNameCheckButton].forEach {
           nickNameStackView.addArrangedSubview($0)
        }
        
        [EssentialInfoTitle, jobLabel, genderLabel, birthLabel, addressLabel, nickNameLabel, checkJobFirstStackView, checkJobSecondStackView, checkGenderFirstStackView, checkGenderSecondStackView, yearStackView, monthStackView, dayStackView, addressStackView, nickNameStackView, nextStepButton, nickNameTitleLabel].forEach {
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
        
        EssentialInfoTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(safeAreaLayoutGuide).inset(24)
            make.width.equalTo(115)
        }
        
        jobLabel.snp.makeConstraints { make in
            make.top.equalTo(EssentialInfoTitle.snp.bottom).offset(28)
            make.leading.equalToSuperview().inset(24)
        }
        
        checkJobFirstStackView.snp.makeConstraints { make in
            make.top.equalTo(jobLabel.snp.bottom).offset(12)
            make.leading.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(18)
        }
        
        checkJobSecondStackView.snp.makeConstraints { make in
            make.top.equalTo(jobLabel.snp.bottom).offset(12)
            make.leading.equalTo(checkJobFirstStackView.snp.trailing).offset(10)
            make.height.equalTo(18)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(checkJobSecondStackView.snp.bottom).offset(29)
            make.leading.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalToSuperview().multipliedBy(0.03)
        }
        
        checkGenderFirstStackView.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(12)
            make.leading.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(18)
        }
        
        checkGenderSecondStackView.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(12)
            make.leading.equalTo(checkGenderFirstStackView.snp.trailing).offset(10)
            make.height.equalTo(18)
        }
        
        birthLabel.snp.makeConstraints { make in
            make.top.equalTo(checkGenderSecondStackView.snp.bottom).offset(28)
            make.leading.equalToSuperview().inset(24)
        }
        
        yearTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.756)
        }
        yearStackView.snp.makeConstraints { make in
            make.top.equalTo(birthLabel.snp.bottom).offset(12)
            make.width.equalToSuperview().multipliedBy(0.1973)
            make.height.equalToSuperview().multipliedBy(0.046)
            make.leading.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        monthTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.719)
        }
        
        monthStackView.snp.makeConstraints { make in
            make.top.equalTo(birthLabel.snp.bottom).offset(12)
            make.leading.equalTo(yearStackView.snp.trailing).offset(11)
            make.width.equalToSuperview().multipliedBy(0.171)
            make.height.equalToSuperview().multipliedBy(0.046)
        }
        
        dayTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.719)
        }
        
        dayStackView.snp.makeConstraints { make in
            make.top.equalTo(birthLabel.snp.bottom).offset(12)
            make.leading.equalTo(monthStackView.snp.trailing).offset(11)
            make.width.equalToSuperview().multipliedBy(0.171)
            make.height.equalToSuperview().multipliedBy(0.046)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(dayStackView.snp.bottom).offset(28)
            make.leading.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        sidoTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        addressStackView.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalToSuperview().multipliedBy(0.062)
        }
        
        nickNameTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(addressStackView.snp.bottom).offset(28)
            make.leading.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        nickNameTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.736)
        }
        
        nickNameStackView.snp.makeConstraints { make in
            make.top.equalTo(nickNameTitleLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalToSuperview().multipliedBy(0.062)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameStackView.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(24)
            make.height.equalToSuperview().multipliedBy(0.03)
        }
        
        nextStepButton.snp.makeConstraints { make in
            
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.872)
            make.height.equalToSuperview().multipliedBy(0.061)
            make.bottom.equalToSuperview().inset(46)
        }
    }
}
