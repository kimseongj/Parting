//
//  UserAgreementViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/09/20.
//

import UIKit
import RxSwift
import RxCocoa

class UserAgreementViewController: BaseViewController<UserAgreementView> {
    private let viewModel: UserAgreementViewModel
    
    init(viewModel: UserAgreementViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        bind()
    }
    
    private func navigationUI() {
        self.navigationController?.isNavigationBarHidden = false
        let leftBarButtonItem = UIBarButtonItem.init(image:  UIImage(named: "backBarButton"), style: .plain, target: self, action: #selector(backBarButtonClicked))
        leftBarButtonItem.tintColor = AppColor.gray700
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        let titleImage = UIImage(named: "JoinUserAgreement")
        navigationItem.titleView = UIImageView(image: titleImage)
    }
    
    private func bind() {
        rootView.serviceAgreeButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, event in
                owner.viewModel.input.onNext(.serviceAgreementClicked)
            })
            .disposed(by: disposeBag)
        
        rootView.personalInfoButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, event in
                owner.viewModel.input.onNext(.personalInfoAgreementClicked)
            })
            .disposed(by: disposeBag)
        
        rootView.nextStepButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, event in
                owner.viewModel.input.onNext(.nextButtonClicked)
            })
            .disposed(by: disposeBag)
        
        viewModel.nextButtonIsValid
            .withUnretained(self)
            .subscribe(onNext: { owner, state in
                owner.rootView.changeButtonColor(buttonType: .nextButton, state: state)
            })
            .disposed(by: disposeBag)
        
        viewModel.state.serviceAgreement
            .withUnretained(self)
            .subscribe(onNext: { owner, state in
                owner.rootView.changeButtonColor(buttonType: .serviceAgreement, state: state)
            })
            .disposed(by: disposeBag)
        
        viewModel.state.personalInfoAgreement
            .withUnretained(self)
            .subscribe(onNext: { owner, state in
                owner.rootView.changeButtonColor(buttonType: .personalInfoAgreement, state: state)
            })
            .disposed(by: disposeBag)
    }
    
    @objc func backBarButtonClicked() {
        viewModel.popUserAgreementVC()
    }
}
