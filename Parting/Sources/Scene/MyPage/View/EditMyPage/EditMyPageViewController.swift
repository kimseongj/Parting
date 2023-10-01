//
//  EditMyPageViewController.swift
//  Parting
//
//  Created by 이병현 on 2023/09/22.
//

import UIKit
import RxCocoa
import Toast

final class EditMyPageViewController: BaseViewController<EditMyPageView> {
    
    private var viewModel: EditMyPageViewModel
    private var firstPickerViewRow: Int = 0
    
    init(viewModel: EditMyPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var interestDataSource: UICollectionViewDiffableDataSource<Int, UIImage>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        setDelegate()
        setupdatePicker()
        setupPickerView()
        setupToolBar()
        setupPickerViewToolBar()
        viewModel.input.onNext(.viewdidLoadTrigger)
        bind()
        setMyInterestDataSource()
        var snapshot = NSDiffableDataSourceSnapshot<Int, UIImage>()
        snapshot.appendSections([0])
        var arr: [UIImage] = [UIImage(named: "관람")!, UIImage(named: "문화생활")!, UIImage(named: "술")!]
        snapshot.appendItems(arr)
        self.interestDataSource.apply(snapshot)
    }
}

extension EditMyPageViewController {
    private func bind() {
        rootView.backBarButton.innerButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.viewModel.popVC()
            }
            .disposed(by: disposeBag)
        
        rootView.manButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.viewModel.state.selectedGender.accept(.man)
            }
            .disposed(by: disposeBag)
        
        rootView.womanButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.viewModel.state.selectedGender.accept(.woman)
            }
            .disposed(by: disposeBag)
        
        viewModel.state.selectedGender
            .withUnretained(self)
            .bind { owner, gender in
                owner.rootView.genderButtonTap(genderCase: gender)
            }
            .disposed(by: disposeBag)
        
        rootView.nameTextField.rx.text
            .withUnretained(self)
            .bind { owner, text in
                guard let text else { return }
                owner.viewModel.state.nameTextField.accept(text)
                owner.rootView.updateDupricatedButton(text: text)
            }
            .disposed(by: disposeBag)
        
        rootView.introduceExplainTextView.rx.text
            .withUnretained(self)
            .bind { owner, text in
                guard let text else { return }
                print(text)
                owner.viewModel.state.introduceTextView.accept(text)
                owner.rootView.updateTextCountLabel(text: text)
                
            }
            .disposed(by: disposeBag)
        
        rootView.sidoTextField.rx.text
            .withUnretained(self)
            .bind { owner, text in
                guard let text else { return }
                owner.viewModel.state.regionTextField.accept(text)
            }
            .disposed(by: disposeBag)
        
        rootView.sigugunTextField.rx.text
            .withUnretained(self)
            .bind { owner, text in
                guard let text else { return }
                owner.viewModel.state.regionTextField.accept(text)
            }
            .disposed(by: disposeBag)
        
        rootView.birthTextField.rx.text
            .withUnretained(self)
            .bind { owner, birth in
                guard let birth else { return }
                owner.viewModel.state.birthTextField.accept(birth)
            }
            .disposed(by: disposeBag)
        
        viewModel.myPageData
            .withUnretained(self)
            .bind { owner, data in
                owner.rootView.configureEditMyPageUI(data)
            }
            .disposed(by: disposeBag)
        
        rootView.duplicatedNickNameCheckButton
            .rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.viewModel.duplicationNickname(nickname: owner.rootView.nameTextField.text ?? "")
            }
            .disposed(by: disposeBag)
        
        viewModel.nickNameDuplicateState
            .withUnretained(self)
            .bind { owner, valid in
                switch valid {
                case true:
                    owner.view.makeToast("사용이 가능한 닉네임입니다.")
                case false:
                    owner.view.makeToast("중복된 닉네임입니다.")
                }
            }
            .disposed(by: disposeBag)
        
        rootView.profileEditButton
            .rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = owner
                owner.present(imagePicker, animated: true)
            }
            .disposed(by: disposeBag)
        
        
        rootView.finishButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, event in
                owner.viewModel.input.onNext(.editCompleteButtonClicked)
            })
            .disposed(by: disposeBag)
        
        
        viewModel.completeButtonIsValid
            .withUnretained(self)
            .subscribe(onNext: { owner, state in
                if state {
                    owner.rootView.configureCompleteButton(state: state)
                } else {
                    owner.rootView.configureCompleteButton(state: state)
                }
                owner.rootView.finishButton.isEnabled = state
            })
            .disposed(by: disposeBag)
    }
}

extension EditMyPageViewController {
    private func navigationUI() {
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = rootView.backBarButton
        self.navigationItem.titleView = rootView.navigationLabel
    }
}

extension EditMyPageViewController {
    private func setMyInterestDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<InterestCollectionViewCell, UIImage> { cell, indexPath, itemIdentifier in
            cell.imageView.image = itemIdentifier
        }
        
        interestDataSource = UICollectionViewDiffableDataSource(collectionView: rootView.myInterestCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
    }
}

extension EditMyPageViewController {
    private func setDelegate() {
        rootView.introduceExplainTextView.delegate = self
        rootView.nameTextField.delegate = self
        rootView.birthTextField.delegate = self
        
        rootView.regionPickerView.delegate = self
        rootView.regionPickerView.dataSource = self
    }
}

extension EditMyPageViewController: UIPickerViewDelegate {
    
}

// MARK: - PickerView
extension EditMyPageViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return viewModel.list.count
        case 1:
            return viewModel.list[firstPickerViewRow].sigungu.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == rootView.regionPickerView {
            switch component {
            case 0:
                return viewModel.list[row].sido.rawValue
            case 1:
                return viewModel.list[firstPickerViewRow].sigungu[row]
            default:
                return nil
            }
        } else {
            return "-"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            firstPickerViewRow = row
            let selectedItem = viewModel.list[firstPickerViewRow]
            let region = selectedItem.sido.rawValue
            rootView.sidoTextField.text = region
            rootView.regionPickerView.reloadAllComponents()
        case 1:
            let selectedItem = viewModel.list[firstPickerViewRow].sigungu[row]
            rootView.sigugunTextField.text = selectedItem
        default:
            return
        }
    }
}

// MARK: - DatePicker
extension EditMyPageViewController {
    private func setupdatePicker() {
        
        rootView.datePicker.datePickerMode = .date
        rootView.datePicker.preferredDatePickerStyle = .inline
        rootView.datePicker.locale = Locale(identifier: "ko-KR")
        rootView.datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        rootView.birthTextField.inputView = rootView.datePicker
        rootView.birthTextField.text = dateFormat(date: Date())
    }
    
    @objc func dateChange(_ sender: UIDatePicker) {
        rootView.birthTextField.text = dateFormat(date: sender.date)
    }
    
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    private func setupToolBar() {
        let toolBar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonHandler))
        
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.sizeToFit()
        
        rootView.birthTextField.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonHandler(_ sender: UIBarButtonItem) {
        rootView.birthTextField.text = dateFormat(date: rootView.datePicker.date)
        
        rootView.birthTextField.resignFirstResponder()
    }
}

extension EditMyPageViewController {
    private func setupPickerView() {
        rootView.sidoTextField.inputView = rootView.regionPickerView
        rootView.sigugunTextField.inputView = rootView.regionPickerView
    }
    
    private func setupPickerViewToolBar() {
        let toolBar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(pickerViewdoneButtonHandler))
        
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.sizeToFit()
        
        rootView.sidoTextField.inputAccessoryView = toolBar
        rootView.sigugunTextField.inputAccessoryView = toolBar
    }
    
    @objc func pickerViewdoneButtonHandler(_ sender: UIBarButtonItem) {
        let row = rootView.regionPickerView.selectedRow(inComponent: 0)
        let row2 = rootView.regionPickerView.selectedRow(inComponent: 1)
        rootView.regionPickerView.selectRow(row, inComponent: 0, animated: false)
        rootView.sidoTextField.text = viewModel.list[row].sido.rawValue
        rootView.sigugunTextField.text = viewModel.list[row].sigungu[row2]
        rootView.sidoTextField.resignFirstResponder()
        rootView.sigugunTextField.resignFirstResponder()
    }
}

extension EditMyPageViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = rootView.introduceExplainTextView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false}
        let changeText = currentText.replacingCharacters(in: stringRange, with: text)
        
        return changeText.count < 41
    }
    
    
}

extension EditMyPageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.rootView.updateProfileImage(image: pickedImage)
            
            if let data = pickedImage.jpegData(compressionQuality: 1) {
                let base64 = data.base64EncodedString()
            }
        }
        self.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
}


extension EditMyPageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
