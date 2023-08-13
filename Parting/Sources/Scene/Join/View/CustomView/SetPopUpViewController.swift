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
        rootView.setupBlurEffect()
    }
    
    init(viewModel: SetPopUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        rootView.noButton.rx.tap
            .bind { [weak self] event in
                self?.viewModel.input.popVCTrigger.onNext(())
            }
            .disposed(by: disposeBag)
    }
    
}
