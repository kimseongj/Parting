//
//  TermsOfServiceViewController.swift
//  Parting
//
//  Created by kimseongjun on 3/6/24.
//

import UIKit
import RxCocoa

final class TermsOfServiceViewController: BaseViewController<TermsOfServiceView> {
    private let barImageTitleButton = BarImageTitleButton(imageName: Images.icon.back, title: "이용약관")

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        bind()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.leftBarButtonItem = barImageTitleButton
    }
}

extension TermsOfServiceViewController {
    private func bind() {
        barImageTitleButton.backButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, tap in
                owner.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
