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
    
    init(viewModel: EssentialInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        checkButtonUI()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        nextButtonClicked()
        jobCheckButtonClicked()
        genderCheckButtonClicked()
        addressTextFieldClicked()
    }
    
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
    
    private func jobCheckButtonClicked() {
        rootView.checkJobFirstStackView.checkButton.rx.tap
            .subscribe(onNext: { _ in
                self.rootView.checkJobFirstStackView.checkButton.backgroundColor = AppColor.brand
                self.rootView.checkJobFirstStackView.checkButton.setImage(UIImage(named: "clickedCheckButton"), for: .normal)
                self.rootView.checkJobFirstStackView.checkAnswerLabel.textColor = UIColor(hexcode: "393939")
                self.rootView.checkJobFirstStackView.checkButton.layer.borderWidth = 0


                self.rootView.checkJobSecondStackView.checkButton.layer.borderColor = AppColor.gray500.cgColor
                self.rootView.checkJobSecondStackView.checkButton.backgroundColor = AppColor.white
                self.rootView.checkJobSecondStackView.checkButton.layer.borderWidth = 1
                self.rootView.checkJobSecondStackView.checkButton.setImage(UIImage(named: "checkButton"), for: .normal)
                self.rootView.checkJobSecondStackView.checkAnswerLabel.textColor = AppColor.gray500
            })
            .disposed(by: disposeBag)
        
        rootView.checkJobSecondStackView.checkButton.rx.tap
            .subscribe(onNext: { _ in
                self.rootView.checkJobSecondStackView.checkButton.backgroundColor = AppColor.brand
                self.rootView.checkJobSecondStackView.checkButton.setImage(UIImage(named: "clickedCheckButton"), for: .normal)
                self.rootView.checkJobSecondStackView.checkAnswerLabel.textColor = UIColor(hexcode: "393939")
                self.rootView.checkJobSecondStackView.checkButton.layer.borderWidth = 0
                
                self.rootView.checkJobFirstStackView.checkButton.layer.borderColor = AppColor.gray500.cgColor
                self.rootView.checkJobFirstStackView.checkButton.backgroundColor = AppColor.white
                self.rootView.checkJobFirstStackView.checkButton.layer.borderWidth = 1
                self.rootView.checkJobFirstStackView.checkButton.setImage(UIImage(named: "checkButton"), for: .normal)
                self.rootView.checkJobFirstStackView.checkAnswerLabel.textColor = AppColor.gray500
            })
            .disposed(by: disposeBag)
    }
    
    private func genderCheckButtonClicked() {
        rootView.checkGenderFirstStackView.checkButton.rx.tap
            .subscribe(onNext: { _ in
                self.rootView.checkGenderFirstStackView.checkButton.backgroundColor = AppColor.brand
                self.rootView.checkGenderFirstStackView.checkButton.setImage(UIImage(named: "clickedCheckButton"), for: .normal)
                self.rootView.checkGenderFirstStackView.checkAnswerLabel.textColor = UIColor(hexcode: "393939")
                self.rootView.checkGenderFirstStackView.checkButton.layer.borderWidth = 0
                
                
                self.rootView.checkGenderSecondStackView.checkButton.layer.borderColor = AppColor.gray500.cgColor
                self.rootView.checkGenderSecondStackView.checkButton.backgroundColor = AppColor.white
                self.rootView.checkGenderSecondStackView.checkButton.layer.borderWidth = 1
                self.rootView.checkGenderSecondStackView.checkButton.setImage(UIImage(named: "checkButton"), for: .normal)
                self.rootView.checkGenderSecondStackView.checkAnswerLabel.textColor = AppColor.gray500
            })
            .disposed(by: disposeBag)
        
        rootView.checkGenderSecondStackView.checkButton.rx.tap
            .subscribe(onNext: { _ in
                self.rootView.checkGenderSecondStackView.checkButton.backgroundColor = AppColor.brand
                self.rootView.checkGenderSecondStackView.checkButton.setImage(UIImage(named: "clickedCheckButton"), for: .normal)
                self.rootView.checkGenderSecondStackView.checkAnswerLabel.textColor = UIColor(hexcode: "393939")
                self.rootView.checkGenderSecondStackView.checkButton.layer.borderWidth = 0
                
                
                self.rootView.checkGenderFirstStackView.checkButton.layer.borderColor = AppColor.gray500.cgColor
                self.rootView.checkGenderFirstStackView.checkButton.backgroundColor = AppColor.white
                self.rootView.checkGenderFirstStackView.checkButton.layer.borderWidth = 1
                self.rootView.checkGenderFirstStackView.checkButton.setImage(UIImage(named: "checkButton"), for: .normal)
                self.rootView.checkGenderFirstStackView.checkAnswerLabel.textColor = AppColor.gray500
            })
            .disposed(by: disposeBag)
    }
    
    
    private func nextButtonClicked() {
        rootView.nextStepButton.rx.tap
            .subscribe(onNext: { _ in
                self.viewModel.input.pushInterestsViewTrigger.onNext(())
            })
            .disposed(by: disposeBag)
    }
    
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
    
    @objc func backBarButtonClicked() {
        self.viewModel.input.popEssentialViewTrigger.onNext(())
    }
    
    private func addressTextFieldClicked() {
        rootView.addressTextField.rx.text
            .subscribe(onNext:{[weak self] _ in
                self?.viewModel.input.getAddressTrigger.onNext(())
            })
            .disposed(by: disposeBag)
    }
}
