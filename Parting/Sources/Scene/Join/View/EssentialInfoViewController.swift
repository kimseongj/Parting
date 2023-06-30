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
    private let disposeBag = DisposeBag()
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
    var sidosigunguText: String = ""
    var sigunguRow: Int = 0
    
    var checkJobButtonSelected = false
    var checkGenderButtonSelected = false
    var checkNicknameValidate = false
    var checkNicknameDuplicated = false
    
    init(viewModel: EssentialInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        checkButtonUI()
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootView.nickNameTextField.delegate = self
        self.viewModel.input.getAddressTrigger.onNext(()) // 주소를 불러오는 API통신 트리거
        navigationUI()
        nextButtonClicked()
        jobCheckButtonClicked()
        genderCheckButtonClicked()
        configureDatePicker()
        birthDateConfigure()
        configurePickerView()
        regionDataBind()
        configureToolBar()
        enterYourNickname()
        checkDuplicatedNickName()
        bind()
        viewModel.isValidForm
            .subscribe(onNext: { flag in
                print("\(flag) 👀👀")
                if flag{
                    self.viewModel.input.pushInterestsViewTrigger.onNext(())
                } else {
                    print("다음단계로 버튼을 다시 검사해야해 🤢🤢🤢")
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - 닉네임 중복 검사
    private func checkDuplicatedNickName() {
        rootView.nickNameCheckButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.viewModel.tapDuplicatedCheckButton()
                let text = self.rootView.nickNameTextField.text
                self.viewModel.input.duplicatedNickNameTrigger.onNext(text)
            })
            .disposed(by: disposeBag)
        
        viewModel.output.duplicatedNickNameCheck
            .subscribe(onNext: { check in
                if check == true {
                    print("사용 가능한 닉네임 입니다.")
                    self.checkNicknameDuplicated = true
                } else {
                    print("중복된 닉네임 입니다.")
                    self.checkNicknameDuplicated = false
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - 닉네임 유효성 검사
    private func enterYourNickname() {
        rootView.nickNameTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: {[weak self] text in
                guard let self else { return }
                let flag = self.viewModel.nicknameValidCheck(text)
                if(flag) {
                    //MARK: - 버튼 활성화
                    print("가입 가능한 닉네임 입니다✅✅")
                    self.rootView.nickNameCheckButton.isEnabled = true
                    self.rootView.nickNameCheckButton.setTitleColor(.black, for: .normal)
                    self.rootView.nickNameCheckButton.layer.borderColor = UIColor.black.cgColor
                    checkNicknameValidate = true
                } else {
                    self.rootView.nickNameCheckButton.isEnabled = false
                    self.rootView.nickNameCheckButton.setTitleColor(UIColor(hexcode: "A7B0C0"), for: .normal)
                    self.rootView.nickNameCheckButton.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
                    checkNicknameValidate = false
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - 시도, 시군구 관련 데이터 바인딩
    private func regionDataBind() {
        self.viewModel.output.sidoCodeData
            .filter { $0 != nil}
            .subscribe(onNext: {[weak self] sidoCD in
                guard let self else { return }
                self.sidoCDData = sidoCD
            })
            .disposed(by: disposeBag)
        
        self.viewModel.output.sidoListData
            .filter { $0 != nil }
            .subscribe(onNext: { [weak self] data in
                guard let self else { return }
                self.sidoListData = data
            })
            .disposed(by: disposeBag)
        
        self.viewModel.output.sigugunListData
            .filter { $0 != nil }
            .subscribe(onNext:{ [weak self] data in
                guard let self else { return }
                guard let sigugunListData = data else { return }
                self.sigugunListData = sigugunListData
            })
            .disposed(by: disposeBag)
        
        self.viewModel.output.sigugunCodeData
            .filter { $0 != nil }
            .subscribe(onNext: {[weak self] data in
                guard let self else { return }
                guard let sigugunCDData = data else { return }
                self.sigugunCDData = sigugunCDData
                
            })
            .disposed(by: disposeBag)
        
        self.viewModel.output.sidoCDDictData
            .filter { $0 != nil}
            .subscribe(onNext: {[weak self] data in
                guard let self else { return }
                guard let sidoCDDict = data else { return }
                self.sidoCDDict = sidoCDDict
            })
            .disposed(by: disposeBag)
        
        self.viewModel.output.sigunguCDDictData
            .filter { $0 != nil }
            .subscribe(onNext: {[weak self] data in
                guard let self else { return }
                guard let sigunguCDDict = data else { return }
                self.sigunguCDDict = sigunguCDDict
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - BirthDate TextField Configure
    private func birthDateConfigure() {
        self.viewModel.output.birthDateData
            .filter { $0 != nil }
            .subscribe(onNext: { [weak self] date in
                guard let self else { return }
                guard let date = date else { return }
                self.rootView.yearTextField.text = date[0]
                self.rootView.monthTextField.text = date[1]
                self.rootView.dayTextField.text = date[2]
                self.birthDate = date[0] + "-" + date[1] + "-" + date[2]
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
            .subscribe(onNext:{[weak self] date in
                guard let self else {return}
                self.viewModel.input.BirthTextFieldTrigger.onNext(date)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Navigation UI
    private func navigationUI() {
        self.navigationController?.isNavigationBarHidden = false
        let leftBarButtonItem = UIBarButtonItem.init(image:  UIImage(named: "backBarButton"), style: .plain, target: self, action: #selector(backBarButtonClicked))
        leftBarButtonItem.tintColor = AppColor.joinText
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        let titleLabel = UILabel()
        titleLabel.text = "필수 정보 입력"
        titleLabel.textColor = AppColor.joinText
        titleLabel.textAlignment = .center
        titleLabel.font = notoSansFont.Regular.of(size: 20)
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
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
            self.rootView.checkJobFirstStackView.checkAnswerLabel.textColor = UIColor(hexcode: "393939")
            self.rootView.checkJobFirstStackView.checkButton.layer.borderWidth = 0

            self.rootView.checkJobSecondStackView.checkButton.layer.borderColor = AppColor.gray500.cgColor
            self.rootView.checkJobSecondStackView.checkButton.backgroundColor = AppColor.white
            self.rootView.checkJobSecondStackView.checkButton.layer.borderWidth = 1
            self.rootView.checkJobSecondStackView.checkButton.setImage(UIImage(named: "checkButton"), for: .normal)
            self.rootView.checkJobSecondStackView.checkAnswerLabel.textColor = AppColor.gray500
        } else {
            self.rootView.checkJobSecondStackView.checkButton.backgroundColor = AppColor.brand
            self.rootView.checkJobSecondStackView.checkButton.setImage(UIImage(named: "clickedCheckButton"), for: .normal)
            self.rootView.checkJobSecondStackView.checkAnswerLabel.textColor = UIColor(hexcode: "393939")
            self.rootView.checkJobSecondStackView.checkButton.layer.borderWidth = 0
            
            self.rootView.checkJobFirstStackView.checkButton.layer.borderColor = AppColor.gray500.cgColor
            self.rootView.checkJobFirstStackView.checkButton.backgroundColor = AppColor.white
            self.rootView.checkJobFirstStackView.checkButton.layer.borderWidth = 1
            self.rootView.checkJobFirstStackView.checkButton.setImage(UIImage(named: "checkButton"), for: .normal)
            self.rootView.checkJobFirstStackView.checkAnswerLabel.textColor = AppColor.gray500
        }
    }
    
    // MARK: - 성별 체크 버튼
    private func genderCheckButtonClicked() {
        rootView.checkGenderFirstStackView.checkButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.viewModel.tapGenderButton(gender: 0)
                self.checkGenderButtonSelected = true
                self.gender = "M"
            })
            .disposed(by: disposeBag)
        
        rootView.checkGenderSecondStackView.checkButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.viewModel.tapGenderButton(gender: 1)
                self.checkGenderButtonSelected = true
                self.gender = "F"
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: = gender 선택 UIUpdate
    private func genderUIUpdate(gender: Int) {
        if gender == 0 {
            self.rootView.checkGenderFirstStackView.checkButton.backgroundColor = AppColor.brand
            self.rootView.checkGenderFirstStackView.checkButton.setImage(UIImage(named: "clickedCheckButton"), for: .normal)
            self.rootView.checkGenderFirstStackView.checkAnswerLabel.textColor = UIColor(hexcode: "393939")
            self.rootView.checkGenderFirstStackView.checkButton.layer.borderWidth = 0

            self.rootView.checkGenderSecondStackView.checkButton.layer.borderColor = AppColor.gray500.cgColor
            self.rootView.checkGenderSecondStackView.checkButton.backgroundColor = AppColor.white
            self.rootView.checkGenderSecondStackView.checkButton.layer.borderWidth = 1
            self.rootView.checkGenderSecondStackView.checkButton.setImage(UIImage(named: "checkButton"), for: .normal)
            self.rootView.checkGenderSecondStackView.checkAnswerLabel.textColor = AppColor.gray500
        } else {
            self.rootView.checkGenderSecondStackView.checkButton.backgroundColor = AppColor.brand
            self.rootView.checkGenderSecondStackView.checkButton.setImage(UIImage(named: "clickedCheckButton"), for: .normal)
            self.rootView.checkGenderSecondStackView.checkAnswerLabel.textColor = UIColor(hexcode: "393939")
            self.rootView.checkGenderSecondStackView.checkButton.layer.borderWidth = 0
            
            self.rootView.checkGenderFirstStackView.checkButton.layer.borderColor = AppColor.gray500.cgColor
            self.rootView.checkGenderFirstStackView.checkButton.backgroundColor = AppColor.white
            self.rootView.checkGenderFirstStackView.checkButton.layer.borderWidth = 1
            self.rootView.checkGenderFirstStackView.checkButton.setImage(UIImage(named: "checkButton"), for: .normal)
            self.rootView.checkGenderFirstStackView.checkAnswerLabel.textColor = AppColor.gray500
        }
    }
    
    // MARK: - 데이터 바인딩
    private func bind() {
        viewModel.genderState
            .subscribe(onNext: { [weak self] gender in
            self?.genderUIUpdate(gender: gender)
        })
            .disposed(by: disposeBag)
        
        viewModel.jobState
            .subscribe(onNext: { [weak self] job in
            self?.jobUIUpdate(job: job)
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
    
    // MARK: - 데이트 피커 완료버튼
    @objc private func completeButtonClicked() {
        guard let sidoData = sidoListData else { return }
        guard let sigugunData = sigugunListData else { return }
        let row1 = regionPicker.selectedRow(inComponent: 0)
        let row2 = regionPicker.selectedRow(inComponent: 1)
        regionPicker.selectRow(row1, inComponent: 0, animated: false)
        regionPicker.selectRow(row2, inComponent: 1, animated: false)
        rootView.sidoTextField.text = sidoData[row1]
        rootView.sigugunTextField.text = sigugunData[row2]
        regionPicker.reloadComponent(1)
        rootView.sidoTextField.resignFirstResponder()
        rootView.sigugunTextField.resignFirstResponder()
    }
    
    // MARK: 데이트 피커 취소버튼
    @objc private func cancelButtonClicked() {
        rootView.sidoTextField.text = nil
        rootView.sigugunTextField.text = nil
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
            .subscribe(onNext: { _ in
                print("버튼 클릭중")
                self.canGoNextStepBindings()
                guard let text = self.rootView.nickNameTextField.text else { return }
                self.nickName = text
                self.viewModel.postEssentialInfo(self.birthDate, self.job, self.nickName, self.gender, self.sigugunCDData?[self.sigunguRow] ?? 0)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: 버튼 체크 UI
    private func checkButtonUI() {
        rootView.checkJobFirstStackView.checkButton.layer.cornerRadius = rootView.checkJobFirstStackView.checkButton.bounds.size.width / 2
        rootView.checkJobFirstStackView.checkButton.clipsToBounds = true
        rootView.checkJobFirstStackView.checkAnswerLabel.text = "네, 직장인입니다."
        
        rootView.checkJobSecondStackView.checkButton.layer.cornerRadius = rootView.checkJobSecondStackView.checkButton.bounds.size.width / 2
        rootView.checkJobSecondStackView.checkButton.clipsToBounds = true
        rootView.checkJobSecondStackView.checkAnswerLabel.text = "아니오, 학생입니다."
        
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
    
    // MARK: - 다음단계로 가는 버튼 유효성 검사
    private func canGoNextStepBindings() {
        // MARK: - jobAndGenderButton이 선택되어 있는지 Check
        viewModel.checkJobAndGenderButtonisSelected.accept(checkJobButtonSelected && checkGenderButtonSelected)
        // rx.isEnabled를 옵저버블로 합쳐서(jobButton, GenderButton)
        
        // MARK: - addressTextField가 채워져있는지 Check
        viewModel.checkAddressNotEmpty.accept(sidosigunguText)
        
        // MARK: - birthTextField가 채워져있는지 Check
        viewModel.checkBirthNotEmpty.accept(birthDate) // ViewModel에서 바로 사용하면 됨
        
        // MARK: - nickNameValidate가 검사되었는지 Check
        viewModel.checkNicknameValidate.accept(checkNicknameValidate)
        
        // MARK: - nickNameDuplicated가 검사되었는지 Check
        viewModel.checkNicknameDuplicated.accept(checkNicknameDuplicated)
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
            guard let sigugunList = sigugunListData?[row] else { return "" }
            return sigugunList
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
            sidosigunguText += text
        case 1:
            let selected = regionPicker.selectedRow(inComponent: 0)
            let selectedName = sidoListData?[selected]
            let data = sidoCDDict?[selectedName ?? ""] ?? 0
            rootView.sigugunTextField.text = sigunguCDDict?[data]?[row] ?? ""
            guard let text = rootView.sigugunTextField.text else { return }
            sidosigunguText += text
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
