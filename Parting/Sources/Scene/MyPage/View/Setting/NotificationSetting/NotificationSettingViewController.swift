//
//  NotificationSettingViewController.swift
//  Parting
//
//  Created by 이병현 on 2023/09/21.
//

import UIKit
import RxCocoa

final class NotificationSettingViewController: BaseViewController<NotificationSettingView> {
    
    private var viewModel: NotificationSettingViewModel
    
    init(viewModel: NotificationSettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.backgroundColor = .clear
        bind()
    }
}

extension NotificationSettingViewController {
    private func bind() {
        rootView.okButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.viewModel.dismissVC()
            }
            .disposed(by: disposeBag)
    }
}
