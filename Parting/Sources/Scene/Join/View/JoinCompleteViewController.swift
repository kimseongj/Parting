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
    private let disposeBag = DisposeBag()

    
    init(viewModel: JoinCompleteViewModel) {
		self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        writeButtonClicked()
    }
    
    private func writeButtonClicked() {
        rootView.writeInfoButton.rx.tap
            .subscribe(onNext: {[weak self] _ in
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
        let titleLabel = UILabel()
        titleLabel.text = "관심사를 설정해주세요"
        titleLabel.textColor = AppColor.joinText
        titleLabel.textAlignment = .center
        titleLabel.font = notoSansFont.Regular.of(size: 20)
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
    }
    
    @objc func backBarButtonClicked() {
		viewModel.input.popJoinCompleteViewTrigger.onNext(())
    }
    
}
