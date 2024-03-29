//
//  EssentialInfoViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/04/20.
//

import UIKit
import RxSwift
import RxCocoa

class EssentialInfoViewController: BaseViewController<EssentialInfoView> {
    private let viewModel: EssentialInfoViewModel
    private let datePicker = UIDatePicker()
    private let regionPicker = UIPickerView()
    
    private(set) var genderState = PublishRelay<Int>()
    private(set) var jobState = PublishRelay<Int>()
    
    var sidoListData: [String]?
    var sigugunListData: [String]?
    var sigugunCDData: [Int]?
    var sidoCDData: [Int]?
    var sidoCDDict: [String: Int]?
    var sigunguCDDict: [Int: [String]]?
    
    var job: String = ""
    var sigungu: Int = 0
    var gender: String = ""
    var nickName: String = ""
    var birthDate: String = ""
    var sigunguRow: Int = 0
    
    var checkJobButtonSelected = false
    var checkGenderButtonSelected = false
    var checkNicknameValidate = false
    var checkNicknameDuplicated = false
    var isValidState: Bool = false
    
    init(viewModel: EssentialInfoViewModel) {
		self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("EssetialInfoVC 메모리 해제")
    }
    
    // MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        checkButtonUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardNotifications()
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getAddress()
        navigationUI()
        nextButtonClicked()
        jobCheckButtonClicked()
        genderCheckButtonClicked()
        configureDatePicker()
        birthDateConfigure()
        configurePickerView()
        regionDataBind()
        configureToolBar()
        configureDateToolBAR()
        enterYourNickname()
        checkDuplicatedNickName()
        bind()
    }
    
    private func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    @objc func keyboardWillShow(_ noti: NSNotification) {
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            rootView.frame.origin.y -= keyboardHeight
        }
    }
    
    @objc func keyBoardWillHide(_ noti: NSNotification) {
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            rootView.frame.origin.y += keyboardHeight
        }
    }
    
    // MARK: - 닉네임 중복 검사
    private func checkDuplicatedNickName() {
        rootView.duplicatedNickNameCheckButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                guard let text = owner.rootView.nickNameTextField.text else { return }
                owner.viewModel.tapDuplicatedCheckButton(nickName: text)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - 닉네임 유효성 검사
    private func enterYourNickname() {
        rootView.nickNameTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .withUnretained(self)
            .subscribe(onNext: {owner, text in
                let flag = owner.viewModel.nicknameValidCheck(text)
                if(flag) {
                    //MARK: - 버튼 활성화
                    print("가입 가능한 닉네임 입니다✅✅")
                    owner.rootView.duplicatedNickNameCheckButton.isEnabled = true
                    owner.rootView.duplicatedNickNameCheckButton.setTitleColor(AppColor.brand, for: .normal)
                    owner.rootView.duplicatedNickNameCheckButton.layer.borderColor = AppColor.brand.cgColor
                    owner.checkNicknameValidate = true
                } else {
                    owner.rootView.duplicatedNickNameCheckButton.isEnabled = false
                    owner.rootView.duplicatedNickNameCheckButton.setTitleColor(UIColor(hexcode: "A7B0C0"), for: .normal)
                    owner.rootView.duplicatedNickNameCheckButton.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
                    owner.checkNicknameValidate = false
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - 시도, 시군구 관련 데이터 바인딩
    private func regionDataBind() {
        viewModel.output.sidoCodeData
            .filter { $0 != nil}
            .withUnretained(self)
            .subscribe(onNext: { owner, sidoCD in
                owner.sidoCDData = sidoCD
            })
            .disposed(by: disposeBag)
        
        viewModel.output.sidoListData
            .filter { $0 != nil }
            .withUnretained(self)
            .subscribe(onNext: { owner, data in
                owner.sidoListData = data
            })
            .disposed(by: disposeBag)
        
        viewModel.output.sigugunListData
            .filter { $0 != nil }
            .withUnretained(self)
            .subscribe(onNext:{ owner, data in
                guard let sigugunListData = data else { return }
                owner.sigugunListData = sigugunListData
            })
            .disposed(by: disposeBag)
        
        viewModel.output.sigugunCodeData
            .filter { $0 != nil }
            .withUnretained(self)
            .subscribe(onNext: { owner, data in
                guard let sigugunCDData = data else { return }
                owner.sigugunCDData = sigugunCDData
            })
            .disposed(by: disposeBag)
        
        viewModel.output.sidoCDDictData
            .filter { $0 != nil}
            .withUnretained(self)
            .subscribe(onNext: { owner, data in
                guard let sidoCDDict = data else { return }
                owner.sidoCDDict = sidoCDDict
            })
            .disposed(by: disposeBag)
        
        viewModel.output.sigunguCDDictData
            .filter { $0 != nil }
            .withUnretained(self)
            .subscribe(onNext: { owner, data in
                guard let sigunguCDDict = data else { return }
                owner.sigunguCDDict = sigunguCDDict
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - BirthDate TextField Configure
    private func birthDateConfigure() {
        viewModel.output.birthDateData
            .withUnretained(self)
            .subscribe(onNext: { owner, date in
                guard let date = date else { return }
                owner.rootView.yearTextField.text = date[0]
                owner.rootView.monthTextField.text = date[1]
                owner.rootView.dayTextField.text = date[2]
                owner.birthDate = date[0] + "-" + date[1] + "-" + date[2]
                owner.viewModel.checkBirthNotEmpty.accept(owner.birthDate)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        datePicker.locale = Locale(identifier: "ko_KR")
        rootView.yearTextField.inputView = self.datePicker
        rootView.monthTextField.inputView = self.datePicker
        rootView.dayTextField.inputView = self.datePicker
    }
    
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        datePicker.rx.date
            .withUnretained(self)
            .subscribe(onNext:{ owner, date in
                owner.viewModel.input.BirthTextFieldTrigger.onNext(date)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Navigation UI
    private func navigationUI() {
        self.navigationController?.isNavigationBarHidden = false
        let leftBarButtonItem = UIBarButtonItem.init(image:  UIImage(named: "backBarButton"), style: .plain, target: self, action: #selector(backBarButtonClicked))
        leftBarButtonItem.tintColor = AppColor.joinText
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        let titleImage = UIImage(named: "JoinFlowEssentialInfo")
        navigationItem.titleView = UIImageView(image: titleImage)
    }
    
    // MARK: - 직업 체크 버튼
    private func jobCheckButtonClicked() {
        rootView.checkJobFirstStackView.checkButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.viewModel.tapJobButton(job: 0)
                owner.checkJobButtonSelected = true
                owner.job = "WORKER"
            })
            .disposed(by: disposeBag)
        
        rootView.checkJobSecondStackView.checkButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.viewModel.tapJobButton(job: 1)
                owner.checkJobButtonSelected = true
                owner.job = "STUDENT"
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - job 선택 UIUpdate
    private func jobUIUpdate(job: Int) {
        if job == 0 {
            self.rootView.checkJobFirstStackView.checkButton.backgroundColor = AppColor.brand
            self.rootView.checkJobFirstStackView.checkButton.setImage(UIImage(named: "clickedCheckButton"), for: .normal)
            self.rootView.checkJobFirstStackView.checkAnswerLabel.textColor = AppColor.gray800
            self.rootView.checkJobFirstStackView.checkButton.layer.borderWidth = 0

            self.rootView.checkJobSecondStackView.checkButton.layer.borderColor = AppColor.gray200.cgColor
            self.rootView.checkJobSecondStackView.checkButton.backgroundColor = AppColor.white
            self.rootView.checkJobSecondStackView.checkButton.layer.borderWidth = 1
            self.rootView.checkJobSecondStackView.checkButton.setImage(UIImage(named: "checkButton"), for: .normal)
            self.rootView.checkJobSecondStackView.checkAnswerLabel.textColor = AppColor.gray200
        } else {
            self.rootView.checkJobSecondStackView.checkButton.backgroundColor = AppColor.brand
            self.rootView.checkJobSecondStackView.checkButton.setImage(UIImage(named: "clickedCheckButton"), for: .normal)
            self.rootView.checkJobSecondStackView.checkAnswerLabel.textColor = AppColor.gray800
            self.rootView.checkJobSecondStackView.checkButton.layer.borderWidth = 0
            
            self.rootView.checkJobFirstStackView.checkButton.layer.borderColor = AppColor.gray200.cgColor
            self.rootView.checkJobFirstStackView.checkButton.backgroundColor = AppColor.white
            self.rootView.checkJobFirstStackView.checkButton.layer.borderWidth = 1
            self.rootView.checkJobFirstStackView.checkButton.setImage(UIImage(named: "checkButton"), for: .normal)
            self.rootView.checkJobFirstStackView.checkAnswerLabel.textColor = AppColor.gray200
        }
    }
    
    // MARK: - 성별 체크 버튼
    private func genderCheckButtonClicked() {
        rootView.checkGenderFirstStackView.checkButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.viewModel.tapGenderButton(gender: 0)
                owner.checkGenderButtonSelected = true
                owner.gender = "M"
            })
            .disposed(by: disposeBag)
        
        rootView.checkGenderSecondStackView.checkButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.viewModel.tapGenderButton(gender: 1)
                owner.checkGenderButtonSelected = true
                owner.gender = "F"
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: gender 선택 UIUpdate
    private func genderUIUpdate(gender: Int) {
        if gender == 0 {
            self.rootView.checkGenderFirstStackView.checkButton.backgroundColor = AppColor.brand
            self.rootView.checkGenderFirstStackView.checkButton.setImage(UIImage(named: "clickedCheckButton"), for: .normal)
            self.rootView.checkGenderFirstStackView.checkAnswerLabel.textColor = UIColor(hexcode: "393939")
            self.rootView.checkGenderFirstStackView.checkButton.layer.borderWidth = 0

            self.rootView.checkGenderSecondStackView.checkButton.layer.borderColor = AppColor.gray200.cgColor
            self.rootView.checkGenderSecondStackView.checkButton.backgroundColor = AppColor.white
            self.rootView.checkGenderSecondStackView.checkButton.layer.borderWidth = 1
            self.rootView.checkGenderSecondStackView.checkButton.setImage(UIImage(named: "checkButton"), for: .normal)
            self.rootView.checkGenderSecondStackView.checkAnswerLabel.textColor = AppColor.gray200
        } else {
            self.rootView.checkGenderSecondStackView.checkButton.backgroundColor = AppColor.brand
            self.rootView.checkGenderSecondStackView.checkButton.setImage(UIImage(named: "clickedCheckButton"), for: .normal)
            self.rootView.checkGenderSecondStackView.checkAnswerLabel.textColor = UIColor(hexcode: "393939")
            self.rootView.checkGenderSecondStackView.checkButton.layer.borderWidth = 0
            
            self.rootView.checkGenderFirstStackView.checkButton.layer.borderColor = AppColor.gray200.cgColor
            self.rootView.checkGenderFirstStackView.checkButton.backgroundColor = AppColor.white
            self.rootView.checkGenderFirstStackView.checkButton.layer.borderWidth = 1
            self.rootView.checkGenderFirstStackView.checkButton.setImage(UIImage(named: "checkButton"), for: .normal)
            self.rootView.checkGenderFirstStackView.checkAnswerLabel.textColor = AppColor.gray200
        }
    }
    
    // MARK: - 데이터 바인딩
    private func bind() {
        viewModel.genderState
            .withUnretained(self)
            .subscribe(onNext: { owner, gender in
            owner.genderUIUpdate(gender: gender)
        })
            .disposed(by: disposeBag)
        
        viewModel.jobState
            .withUnretained(self)
            .subscribe(onNext: { owner, job in
            owner.jobUIUpdate(job: job)
        })
            .disposed(by: disposeBag)
        
        viewModel.nickNameDuplicateState
            .withUnretained(self)
            .subscribe(onNext: { owner, isDuplicated in
                if isDuplicated {
                    owner.checkNicknameDuplicated = true
                } else {
                    owner.checkNicknameDuplicated = false
                }
            })
            .disposed(by: disposeBag)
        
        rootView.sidoTextField.rx.text
            .withUnretained(self)
            .subscribe(onNext: { owner, text in
                owner.viewModel.checkAddressNotEmpty.accept(text)
            })
            .disposed(by: disposeBag)
        
        rootView.sigugunTextField.rx.text
            .withUnretained(self)
            .subscribe(onNext: { owner, text in
                owner.viewModel.checkAddressNotEmpty.accept(text)
            })
            .disposed(by: disposeBag)
        
        viewModel.isValidForm
            .withUnretained(self)
            .subscribe(onNext: {owner, flag in
                owner.isValidState = flag
                owner.rootView.changeButtonColor(state: owner.isValidState)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - 시도, 시군구 피커뷰 ToolBar UI
    private func configureToolBar() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let completeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeButtonClicked))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
        
        toolBar.setItems([cancelButton,flexibleSpace,completeButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        rootView.sidoTextField.inputAccessoryView = toolBar
        rootView.sigugunTextField.inputAccessoryView = toolBar
    }
    
    private func configureDateToolBAR() {
        let toolBar = UIToolbar()
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let completeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(dateCompleteButtonClicked))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(dateCancelButtonClicked))
        
        toolBar.setItems([cancelButton,flexibleSpace,completeButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        rootView.yearTextField.inputAccessoryView = toolBar
        rootView.monthTextField.inputAccessoryView = toolBar
        rootView.dayTextField.inputAccessoryView = toolBar
    }
    
    // MARK: - 피커뷰 완료버튼
    @objc private func completeButtonClicked() {
        guard let sidoData = sidoListData else { return }
        guard let sigugunData = sigugunListData else { return }
        let row1 = regionPicker.selectedRow(inComponent: 0)
        let row2 = regionPicker.selectedRow(inComponent: 1)
        regionPicker.selectRow(row1, inComponent: 0, animated: false)
        regionPicker.selectRow(row2, inComponent: 1, animated: false)
        if row1 <= sidoData.count && row2 <= sigugunData.count {
            rootView.sidoTextField.text = sidoData[row1]
            rootView.sigugunTextField.text = sigugunData[row2]
        }
        regionPicker.reloadComponent(1)
        rootView.sidoTextField.resignFirstResponder()
        rootView.sigugunTextField.resignFirstResponder()
        
        rootView.yearTextField.resignFirstResponder()
        rootView.monthTextField.resignFirstResponder()
        rootView.dayTextField.resignFirstResponder()
    }
    
    // MARK: 데이트 피커 취소버튼
    @objc private func cancelButtonClicked() {
        rootView.sidoTextField.text = nil
        rootView.sigugunTextField.text = nil
        rootView.resignFirstResponder()
    }
    
    // MARK: - 년,월,일 완료버튼
    @objc private func dateCompleteButtonClicked() {
        rootView.yearTextField.resignFirstResponder()
        rootView.monthTextField.resignFirstResponder()
        rootView.dayTextField.resignFirstResponder()
    }
    
    // MARK: 년,월,일 취소버튼
    @objc private func dateCancelButtonClicked() {
        rootView.resignFirstResponder()
    }
    
    // MARK: 피커뷰 delegate, datasource 설정
    private func configurePickerView() {
        regionPicker.delegate = self
        regionPicker.dataSource = self
        rootView.sidoTextField.inputView = regionPicker
        rootView.sigugunTextField.inputView = regionPicker
    }
    
    // MARK: 다음단계로 버튼 클릭
    private func nextButtonClicked() {
        rootView.nextStepButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                print("버튼 클릭중")
                owner.viewModel.tapNextButton(isValid: owner.isValidState)
                guard let text = owner.rootView.nickNameTextField.text else { return }
                owner.nickName = text
                owner.viewModel.postEssentialInfo(
                    owner.birthDate,
                    owner.job,
                    owner.nickName,
                    owner.gender,
                    owner.sigugunCDData?[owner.sigunguRow] ?? 0
                )
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: 버튼 체크 UI
    private func checkButtonUI() {
        rootView.checkJobFirstStackView.checkButton.layer.cornerRadius = rootView.checkJobFirstStackView.checkButton.bounds.size.width / 2
        rootView.checkJobFirstStackView.checkButton.clipsToBounds = true
        rootView.checkJobFirstStackView.checkAnswerLabel.text = "네"
        
        rootView.checkJobSecondStackView.checkButton.layer.cornerRadius = rootView.checkJobSecondStackView.checkButton.bounds.size.width / 2
        rootView.checkJobSecondStackView.checkButton.clipsToBounds = true
        rootView.checkJobSecondStackView.checkAnswerLabel.text = "아니오"
        
        rootView.checkGenderFirstStackView.checkButton.layer.cornerRadius = rootView.checkGenderFirstStackView.checkButton.bounds.size.width / 2
        rootView.checkGenderFirstStackView.checkButton.clipsToBounds = true
        rootView.checkGenderFirstStackView.checkAnswerLabel.text = "남자"
        
        rootView.checkGenderSecondStackView.checkButton.layer.cornerRadius = rootView.checkGenderSecondStackView.checkButton.bounds.size.width / 2
        rootView.checkGenderSecondStackView.checkButton.clipsToBounds = true
        rootView.checkGenderSecondStackView.checkAnswerLabel.text = "여자"
    }
    
    // MARK: 네비게이션 바 Back Button Click
    @objc private func backBarButtonClicked() {
        viewModel.input.popEssentialViewTrigger.onNext(())
    }
}

// MARK: - UIPickerView Delegate
extension EssentialInfoViewController: UIPickerViewDelegate {
    
}

// MARK: - UIPickerView DataSource
extension EssentialInfoViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            guard let data = sidoListData else { return 1 }
            return data.count
        case 1:
            let selected = regionPicker.selectedRow(inComponent: 0)
            guard let selectedName = sidoListData?[selected] else { return 0 }
            guard let data = sigunguCDDict?[sidoCDDict?[selectedName] ?? 0] else { return 1 }
            return data.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            guard let data = sidoListData else { return "" }
            return data[row]
        case 1:
            let selected = regionPicker.selectedRow(inComponent: 0)
            guard let selectedName = sidoListData?[selected] else { return "" }
            let data = sidoCDDict?[selectedName] ?? 0
            sigugunListData = sigunguCDDict?[data]
            if let sigugunListData = sigugunListData, row < sigugunListData.count {
                let sigugunList = sigugunListData[row]
                return sigugunList
                // 유효한 값에 대한 처리
            } else {
                return "" // 유효한 값이 없을 경우 처리
            }
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            regionPicker.reloadComponent(1)
            guard let data = sidoListData else { return }
            rootView.sidoTextField.text = data[row]
            guard let text = rootView.sidoTextField.text else { return }
        case 1:
            let selected = regionPicker.selectedRow(inComponent: 0)
            let selectedName = sidoListData?[selected]
            let data = sidoCDDict?[selectedName ?? ""] ?? 0
            if row <= sigunguCDDict?[data]?.count ?? 0 {
                rootView.sigugunTextField.text = sigunguCDDict?[data]?[row] ?? ""
            }
            guard let text = rootView.sigugunTextField.text else { return }
        default:
            break
        }
    }
}

// MARK: - TextField Delegate
extension EssentialInfoViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder() // TextField 비활성화
            return true
        }
}
