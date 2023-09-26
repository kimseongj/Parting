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
    
    private let datePicker = UIDatePicker()
    
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
        viewModel.input.viewDidLoadTrigger.accept(())
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
                owner.viewModel.selectedGender.accept(.man)
            }
            .disposed(by: disposeBag)
        
        rootView.womanButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.viewModel.selectedGender.accept(.woman)
            }
            .disposed(by: disposeBag)
        
        viewModel.selectedGender
            .withUnretained(self)
            .bind { owner, gender in
                owner.rootView.genderButtonTap(genderCase: gender)
            }
            .disposed(by: disposeBag)
        
        rootView.nameTextField.rx.text
            .withUnretained(self)
            .bind { owner, text in
                guard let text else { return }
                owner.rootView.updateDupricatedButton(text: text)
            }
            .disposed(by: disposeBag)
        
        rootView.introduceExplainTextView.rx.text
            .withUnretained(self)
            .bind { owner, text in
                guard let text else { return }
                print(text)
                owner.rootView.updateTextCountLabel(text: text)
                
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

extension EditMyPageViewController {
    private func configureDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        datePicker.locale = Locale(identifier: "ko_KR")
        rootView.birthTextField.inputView = self.datePicker
    }
    
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        datePicker.rx.date
            .withUnretained(self)
            .subscribe(onNext:{ owner, date in
                owner.viewModel.input.BirthTextFieldTrigger.onNext(date)
                print(date)
            })
            .disposed(by: disposeBag)
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
