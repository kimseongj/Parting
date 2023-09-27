//
//  LogoutViewController.swift
//  Parting
//
//  Created by 이병현 on 2023/09/22.
//

import UIKit
import RxCocoa

final class LogoutAlertViewController: BaseViewController<LogoutAlertView> {
    
    private var viewModel: LogoutAlertViewModel
    
    init(viewModel: LogoutAlertViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.backgroundColor = .clear
        bind()
    }
}

extension LogoutAlertViewController {
    private func bind() {
        rootView.alertView.okButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.viewModel.dismissVC()
            }
            .disposed(by: disposeBag)
        
        rootView.alertView.cancelButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.viewModel.dismissVC()
            }
            .disposed(by: disposeBag)
    }
}
