//
//  SetPopUpViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/08/13.
//

import UIKit
import RxSwift
import RxCocoa

class SetPopUpViewController: BaseViewController<SetPopUpCustomView> {
    private let viewModel: SetPopUpViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    init(viewModel: SetPopUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func popButtonUIUpdate(state: Int) {
        switch state {
        case 0:
            rootView.yesButton.setTitleColor(AppColor.brand, for: .normal)
            rootView.noButton.setTitleColor(AppColor.gray500, for: .normal)
        case 1:
            rootView.yesButton.setTitleColor(AppColor.brand, for: .normal)
            rootView.noButton.setTitleColor(AppColor.gray500, for: .normal)
        default:
            break
        }
    }
    
    private func bind() {
        rootView.noButton.rx.tap
            .bind { [weak self] event in
                self?.viewModel.tapPopUpButton(state: 0)
                self?.viewModel.input.popVCTrigger.onNext(())
            }
            .disposed(by: disposeBag)
        
        rootView.yesButton.rx.tap
            .bind { [weak self] event in
                self?.viewModel.tapPopUpButton(state: 1)
                self?.viewModel.input.popVCTrigger.onNext(())
            }
            .disposed(by: disposeBag)
        
        viewModel.popUpButtonIsClicked
            .withUnretained(self)
            .subscribe(onNext: { owner, state in
                owner.popButtonUIUpdate(state: state)
            })
            .disposed(by: disposeBag)
        
        
    }
}
