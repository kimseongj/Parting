//
//  CheckMyPartyViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/08/16.
//

import UIKit
import RxSwift
import RxCocoa

class CheckMyPartyViewController: BaseViewController<PartyListView> {
    private let viewModel: CheckMyPartyViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        bind()
    }
    
    init(viewModel: CheckMyPartyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("CheckMyPartyVC 메모리 해제")
    }
    
    private func navigationUI() {
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.rightBarButtonItem = rootView.bellBarButton
        self.navigationItem.leftBarButtonItem = rootView.backBarButton
        self.navigationItem.titleView = BarTitleLabel(text: "내가 개설한 파티")
    }
    
    private func bind() {
        rootView.backBarButton.innerButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: {owner, _ in
                owner.viewModel.popVC()
            })
            .disposed(by: disposeBag)
    }
}
