//
//  EssentialInfoViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/04/20.
//

import UIKit
import RxSwift
import RxCocoa

class EssentialInfoViewController: UIViewController {
    private let mainView = EssentialInfoView()
    private let viewModel: EssentialInfoViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: EssentialInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        self.view = mainView
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
    
    private func genderCheckButtonClicked() {
        mainView.checkGenderFirstStackView.checkButton.rx.tap
            .subscribe(onNext: { _ in
                self.viewModel.input.firstGenderCheckButtonTrigger.onNext(())
                self.viewModel.output.firstGenderCheckButtonUpdate
                    .subscribe(onNext: { _ in
                        self.mainView.checkGenderFirstStackView.checkButton.backgroundColor = AppColor.brand
                        self.mainView.checkGenderFirstStackView.checkButton.setImage(UIImage(named: "clickedCheckButton"), for: .normal)
                        self.mainView.checkGenderFirstStackView.checkAnswerLabel.textColor = UIColor(hexcode: "393939")
                        self.mainView.checkGenderFirstStackView.checkButton.layer.borderWidth = 0
                        
                        
                        self.mainView.checkGenderSecondStackView.checkButton.layer.borderColor = AppColor.gray500.cgColor
                        self.mainView.checkGenderSecondStackView.checkButton.backgroundColor = AppColor.white
                        self.mainView.checkGenderSecondStackView.checkButton.layer.borderWidth = 1
                        self.mainView.checkGenderSecondStackView.checkButton.setImage(UIImage(named: "checkButton"), for: .normal)
                        self.mainView.checkGenderSecondStackView.checkAnswerLabel.textColor = AppColor.gray500
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        mainView.checkGenderSecondStackView.checkButton.rx.tap
            .subscribe(onNext: { _ in
                self.viewModel.input.secondGenderCheckButtonTrigger.onNext(())
                self.viewModel.output.secondGenderCheckButtonUpdate
                    .subscribe(onNext: { _ in
                        self.mainView.checkGenderSecondStackView.checkButton.backgroundColor = AppColor.brand
                        self.mainView.checkGenderSecondStackView.checkButton.setImage(UIImage(named: "clickedCheckButton"), for: .normal)
                        self.mainView.checkGenderSecondStackView.checkAnswerLabel.textColor = UIColor(hexcode: "393939")
                        self.mainView.checkGenderSecondStackView.checkButton.layer.borderWidth = 0
                        
                        
                        self.mainView.checkGenderFirstStackView.checkButton.layer.borderColor = AppColor.gray500.cgColor
                        self.mainView.checkGenderFirstStackView.checkButton.backgroundColor = AppColor.white
                        self.mainView.checkGenderFirstStackView.checkButton.layer.borderWidth = 1
                        self.mainView.checkGenderFirstStackView.checkButton.setImage(UIImage(named: "checkButton"), for: .normal)
                        self.mainView.checkGenderFirstStackView.checkAnswerLabel.textColor = AppColor.gray500
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
    }
    
    private func jobCheckButtonClicked() {
        mainView.checkJobFirstStackView.checkButton.rx.tap
            .subscribe(onNext: { _ in
                self.viewModel.input.firstJobCheckButtonTrigger.onNext(())
                self.viewModel.output.firstJobCheckButtonUpdate
                    .subscribe(onNext: { _ in
                        self.mainView.checkJobFirstStackView.checkButton.backgroundColor = AppColor.brand
                        self.mainView.checkJobFirstStackView.checkButton.setImage(UIImage(named: "clickedCheckButton"), for: .normal)
                        self.mainView.checkJobFirstStackView.checkAnswerLabel.textColor = UIColor(hexcode: "393939")
                        self.mainView.checkJobFirstStackView.checkButton.layer.borderWidth = 0
                        
                        
                        self.mainView.checkJobSecondStackView.checkButton.layer.borderColor = AppColor.gray500.cgColor
                        self.mainView.checkJobSecondStackView.checkButton.backgroundColor = AppColor.white
                        self.mainView.checkJobSecondStackView.checkButton.layer.borderWidth = 1
                        self.mainView.checkJobSecondStackView.checkButton.setImage(UIImage(named: "checkButton"), for: .normal)
                        self.mainView.checkJobSecondStackView.checkAnswerLabel.textColor = AppColor.gray500
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
        mainView.checkJobSecondStackView.checkButton.rx.tap
            .subscribe(onNext: { _ in
                self.viewModel.input.secondJobCheckButtonTrigger.onNext(())
                self.viewModel.output.secondJobCheckButtonUpdate
                    .subscribe(onNext: { _ in
                        self.mainView.checkJobSecondStackView.checkButton.backgroundColor = AppColor.brand
                        self.mainView.checkJobSecondStackView.checkButton.setImage(UIImage(named: "clickedCheckButton"), for: .normal)
                        self.mainView.checkJobSecondStackView.checkAnswerLabel.textColor = UIColor(hexcode: "393939")
                        self.mainView.checkJobSecondStackView.checkButton.layer.borderWidth = 0
                        
                        self.mainView.checkJobFirstStackView.checkButton.layer.borderColor = AppColor.gray500.cgColor
                        self.mainView.checkJobFirstStackView.checkButton.backgroundColor = AppColor.white
                        self.mainView.checkJobFirstStackView.checkButton.layer.borderWidth = 1
                        self.mainView.checkJobFirstStackView.checkButton.setImage(UIImage(named: "checkButton"), for: .normal)
                        self.mainView.checkJobFirstStackView.checkAnswerLabel.textColor = AppColor.gray500
                    })
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
    }
    
    private func nextButtonClicked() {
        mainView.nextStepButton.rx.tap
            .subscribe(onNext: { _ in
                self.viewModel.input.pushInterestsViewTrigger.onNext(())
            })
            .disposed(by: disposeBag)
    }
    
    private func checkButtonUI() {
        mainView.checkJobFirstStackView.checkButton.layer.cornerRadius = mainView.checkJobFirstStackView.checkButton.bounds.size.width / 2
        mainView.checkJobFirstStackView.checkButton.clipsToBounds = true
        mainView.checkJobFirstStackView.checkAnswerLabel.text = "네, 직장인입니다."
        
        
        mainView.checkJobSecondStackView.checkButton.layer.cornerRadius = mainView.checkJobSecondStackView.checkButton.bounds.size.width / 2
        mainView.checkJobSecondStackView.checkButton.clipsToBounds = true
        mainView.checkJobSecondStackView.checkAnswerLabel.text = "아니오, 학생입니다."
        
        
        mainView.checkGenderFirstStackView.checkButton.layer.cornerRadius = mainView.checkGenderFirstStackView.checkButton.bounds.size.width / 2
        mainView.checkGenderFirstStackView.checkButton.clipsToBounds = true
        mainView.checkGenderFirstStackView.checkAnswerLabel.text = "남자"
        
        mainView.checkGenderSecondStackView.checkButton.layer.cornerRadius = mainView.checkGenderSecondStackView.checkButton.bounds.size.width / 2
        mainView.checkGenderSecondStackView.checkButton.clipsToBounds = true
        mainView.checkGenderSecondStackView.checkAnswerLabel.text = "여자"
    }
    
    @objc func backBarButtonClicked() {
        self.viewModel.input.popEssentialViewTrigger.onNext(())
    }
}
