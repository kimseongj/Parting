//
//  EnterPartyViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/08/22.
//

import UIKit
import RxSwift
import RxCocoa

class EnterPartyViewController: BaseViewController<MypageCommonView>, MyPageProtocol {
    
    private let viewModel: EnterPartyViewModel
    
    init(viewModel: EnterPartyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        cellRegister()
        setTableViewDelegateAndDataSource()
        bind()
    }
    
    deinit {
        print("EnterPartyVC 메모리에서 해제되었습니다.")
    }
    
    private func navigationUI() {
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.rightBarButtonItem = rootView.bellBarButton
        self.navigationItem.leftBarButtonItem = rootView.backBarButton
        self.navigationItem.titleView = BarTitleLabel(text: "내가 참여한 파티")
    }
    
    func cellRegister() {
        rootView.partyListTableView.register(PartyTableViewCell.self, forCellReuseIdentifier: PartyTableViewCell.identifier)
        
    }
    
    func setTableViewDelegateAndDataSource() {
        rootView.partyListTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        rootView.backBarButton.innerButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.viewModel.popVC()
            })
            .disposed(by: disposeBag)
        
        viewModel.myPartyList
            .bind(to: rootView.partyListTableView.rx.items(cellIdentifier: PartyTableViewCell.identifier, cellType: PartyTableViewCell.self)) { [weak self] index, party, cell in
                print(index, party, cell, "partyList 🐼🐼")
                cell.configureMyPageCell(party: party)
            }
            .disposed(by: disposeBag)
    }
}

extension EnterPartyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = rootView.window?.windowScene?.screen.bounds.height
        return (height ?? 852.0) * 0.25
    }
}

extension EnterPartyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.myPartyList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
