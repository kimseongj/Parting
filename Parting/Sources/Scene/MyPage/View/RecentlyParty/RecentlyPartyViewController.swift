//
//  RecentlyPartyViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/08/21.
//

import UIKit
import RxSwift
import RxCocoa

class RecentlyPartyViewController: BaseViewController<MypageCommonView> {
    
    private var viewModel: RecentlyPartyViewModel
    
    init(viewModel: RecentlyPartyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        bind()
    }
    
    deinit {
        print("RecentlyParty 메모리에서 해제되었습니다.")
    }
    
    private func navigationUI() {
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.rightBarButtonItem = rootView.bellBarButton
        self.navigationItem.leftBarButtonItem = rootView.backBarButton
        self.navigationItem.titleView = BarTitleLabel(text: "최근 본 파티")
        
    }
    
    private func bind() {
        rootView.backBarButton.innerButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                print("tap")
                owner.viewModel.popVC()
            })
            .disposed(by: disposeBag)
    }
}
