//
//  EssentialInfoView.swift
//  Parting
//
//  Created by 박시현 on 2023/04/20.
//

import UIKit
import SnapKit

class EssentialInfoView: BaseView {
    let jobLabel: UILabel = {
        let label = UILabel()
        label.text = "직업이 있으신가요?"
        label.font = notoSansFont.Regular.of(size: 11)
        return label
    }()
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "성별을 입력해주세요"
        label.font = notoSansFont.Regular.of(size: 11)
        return label
    }()
    
    let birthLabel: UILabel = {
        let label = UILabel()
        label.text = "생년월일"
        label.font = notoSansFont.Regular.of(size: 11)
        return label
    }()
    
    let yearTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = AppColor.gray100
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
        textField.font = notoSansFont.Regular.of(size: 13)
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        return textField
    }()
    
    let yearLiteralLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexcode: "A7B0C0")
        label.text = "년"
        label.font = notoSansFont.Regular.of(size: 13)
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
        textField.backgroundColor = AppColor.gray100
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
        textField.layer.borderWidth = 1
        textField.font = notoSansFont.Regular.of(size: 13)
        textField.textAlignment = .center
        return textField
    }()
    
    let monthLiteralLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexcode: "A7B0C0")
        label.text = "월"
        label.font = notoSansFont.Regular.of(size: 13)
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
        textField.backgroundColor = AppColor.gray100
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
        textField.layer.borderWidth = 1
        textField.font = notoSansFont.Regular.of(size: 13)
        textField.textAlignment = .center
        return textField
    }()
    
    let dayLiteralLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexcode: "A7B0C0")
        label.text = "일"
        label.font = notoSansFont.Regular.of(size: 13)
        return label
    }()
    
    let dayStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 6
        return view
    }()
    
    let checkJobFirstStackView: essentialInfoStackView = {
        let view = essentialInfoStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 11
        return view
    }()
    
    let checkJobSecondStackView: essentialInfoStackView = {
        let view = essentialInfoStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 11
        return view
    }()
    
    let checkGenderFirstStackView: essentialInfoStackView = {
        let view = essentialInfoStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 11
        return view
    }()
    
    let checkGenderSecondStackView: essentialInfoStackView = {
        let view = essentialInfoStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 11
        return view
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = notoSansFont.Regular.of(size: 11)
        label.text = "주소를 입력해주세요"
        return label
    }()
    
    let sidoTextField: UITextField = {
        let textField = UITextField()
        textField.font = notoSansFont.Regular.of(size: 13)
        textField.attributedPlaceholder = NSAttributedString(string: "시도 선택", attributes: [.foregroundColor: UIColor(hexcode: "A7B0C0"), .font: notoSansFont.Regular.of(size: 13)])
        textField.backgroundColor = AppColor.gray100
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        return textField
    }()
    
    let sigugunTextField: UITextField = {
        let textField = UITextField()
        textField.font = notoSansFont.Regular.of(size: 13)
        textField.attributedPlaceholder = NSAttributedString(string: "시군구 선택", attributes: [.foregroundColor: UIColor(hexcode: "A7B0C0"), .font: notoSansFont.Regular.of(size: 13)])
        textField.backgroundColor = AppColor.gray100
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
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
        label.font = notoSansFont.Regular.of(size: 11)
        label.text = "앱 이용 시 나의 프로필 이름으로 표시됩니다"
        return label
    }()
    
    let nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = notoSansFont.Regular.of(size: 13)
        textField.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [.foregroundColor: UIColor(hexcode: "A7B0C0"), .font: notoSansFont.Regular.of(size: 13)])
        textField.backgroundColor = AppColor.gray100
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
        textField.layer.borderWidth = 1
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        textField.leftViewMode = .always
        return textField
    }()
    
    let nickNameCheckButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.backgroundColor = AppColor.gray100
        button.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = notoSansFont.Regular.of(size: 13)
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
    
    let nextStepButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음 단계로", for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = AppColor.brand
        button.titleLabel?.font = notoSansFont.Bold.of(size: 20)
        button.setTitleColor(AppColor.white, for: .normal)
        return button
    }()
    
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
        
        [nickNameTextField, nickNameCheckButton].forEach {
           nickNameStackView.addArrangedSubview($0)
        }
        
        [jobLabel, genderLabel, birthLabel, addressLabel, nickNameLabel, checkJobFirstStackView, checkJobSecondStackView, checkGenderFirstStackView, checkGenderSecondStackView, yearStackView, monthStackView, dayStackView, addressStackView, nickNameStackView, nextStepButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func makeConstraints() {
        jobLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0.1576 * UIScreen.main.bounds.height)
            make.leading.equalToSuperview().inset(20)
            make.width.equalToSuperview().multipliedBy(0.245)
            make.height.equalToSuperview().multipliedBy(0.03)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(checkJobSecondStackView.snp.bottom).offset(0.049 * UIScreen.main.bounds.height)
            make.leading.equalToSuperview().inset(20)
            make.width.equalToSuperview().multipliedBy(0.26)
            make.height.equalToSuperview().multipliedBy(0.03)
        }
        
        birthLabel.snp.makeConstraints { make in
            make.top.equalTo(checkGenderSecondStackView.snp.bottom).offset(0.049 * UIScreen.main.bounds.height)
            make.leading.equalToSuperview().inset(20)
            make.width.equalToSuperview().multipliedBy(0.12)
            make.height.equalToSuperview().multipliedBy(0.03)
        }
        
        checkJobFirstStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0.1576 * UIScreen.main.bounds.height)
            make.trailing.equalToSuperview().inset(0.29 * UIScreen.main.bounds.width)
            make.leading.equalTo(jobLabel.snp.trailing).offset(20)
            make.height.equalToSuperview().multipliedBy(0.03)
        }
        
        checkJobSecondStackView.snp.makeConstraints { make in
            make.top.equalTo(checkJobFirstStackView.snp.bottom).offset(11)
            make.trailing.equalToSuperview().inset(0.29 * UIScreen.main.bounds.width)
            make.leading.equalTo(jobLabel.snp.trailing).offset(20)
            make.height.equalToSuperview().multipliedBy(0.03)
        }
        
        checkGenderFirstStackView.snp.makeConstraints { make in
            make.top.equalTo(checkJobSecondStackView.snp.bottom).offset(0.049 * UIScreen.main.bounds.height)
            make.trailing.equalToSuperview().inset(0.48 * UIScreen.main.bounds.width)
            make.leading.equalTo(genderLabel.snp.trailing).offset(18)
            make.height.equalToSuperview().multipliedBy(0.03)
        }
        
        checkGenderSecondStackView.snp.makeConstraints { make in
            make.top.equalTo(checkGenderFirstStackView.snp.bottom).offset(11)
            make.trailing.equalToSuperview().inset(0.48 * UIScreen.main.bounds.width)
            make.leading.equalTo(genderLabel.snp.trailing).offset(18)
            make.height.equalToSuperview().multipliedBy(0.03)
        }
        
        yearTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.756)
        }
        yearStackView.snp.makeConstraints { make in
            make.top.equalTo(checkGenderSecondStackView.snp.bottom).offset(0.049 * UIScreen.main.bounds.height)
            make.width.equalToSuperview().multipliedBy(0.1973)
            make.height.equalToSuperview().multipliedBy(0.046)
            make.leading.equalTo(birthLabel.snp.trailing).offset(0.184 * UIScreen.main.bounds.width)
        }
        
        monthTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.719)
        }
        
        monthStackView.snp.makeConstraints { make in
            make.top.equalTo(checkGenderSecondStackView.snp.bottom).offset(0.049 * UIScreen.main.bounds.height)
            make.leading.equalTo(yearStackView.snp.trailing).offset(11)
            make.width.equalToSuperview().multipliedBy(0.171)
            make.height.equalToSuperview().multipliedBy(0.046)
        }
        
        dayTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.719)
        }
        
        dayStackView.snp.makeConstraints { make in
            make.top.equalTo(checkGenderSecondStackView.snp.bottom).offset(0.049 * UIScreen.main.bounds.height)
            make.leading.equalTo(monthStackView.snp.trailing).offset(11)
            make.width.equalToSuperview().multipliedBy(0.171)
            make.height.equalToSuperview().multipliedBy(0.046)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(dayStackView.snp.bottom).offset(0.049 * UIScreen.main.bounds.height)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.03)
        }
        sidoTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        addressStackView.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalToSuperview().multipliedBy(0.062)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(addressStackView.snp.bottom).offset(0.049 * UIScreen.main.bounds.height)
            make.leading.equalToSuperview().inset(20)
            make.width.equalToSuperview().multipliedBy(0.53)
            make.height.equalToSuperview().multipliedBy(0.03)
        }
        
        nickNameTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.736)
        }
        
        nickNameStackView.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalToSuperview().multipliedBy(0.062)
        }
        
        nextStepButton.snp.makeConstraints { make in
            make.top.equalTo(nickNameStackView.snp.bottom).offset(0.05 * UIScreen.main.bounds.height)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.872)
            make.height.equalToSuperview().multipliedBy(0.061)
        }
    }
}
