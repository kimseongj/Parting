//
//  JoinCompleteViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/04/20.
//

import UIKit
import RxSwift
import RxCocoa

class JoinCompleteViewController: BaseViewController<JoinCompleteView> {
    private let viewModel: JoinCompleteViewModel

    init(viewModel: JoinCompleteViewModel) {
		self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("JoinCompleteVC 메모리 해제")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        writeButtonClicked()
    }
    
    private func writeButtonClicked() {
        rootView.writeInfoButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
				viewModel.input.pushEssentialInfoViewTrigger.onNext(())
            })
            .disposed(by: disposeBag)
    }
    
    private func navigationUI() {
        self.navigationController?.isNavigationBarHidden = false
        let leftBarButtonItem = UIBarButtonItem.init(image:  UIImage(named: "backBarButton"), style: .plain, target: self, action: #selector(backBarButtonClicked))
        leftBarButtonItem.tintColor = AppColor.joinText
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        let titleLabel = JoinNavigationBar(type: .JoinComplete)
        navigationItem.titleView = titleLabel
    }
    
    @objc func backBarButtonClicked() {
		viewModel.input.popJoinCompleteViewTrigger.onNext(())
    }
}

