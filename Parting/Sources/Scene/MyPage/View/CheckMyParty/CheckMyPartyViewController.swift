//
//  CheckMyPartyViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/08/16.
//

import UIKit
import RxSwift
import RxCocoa

class CheckMyPartyViewController: BaseViewController<PartyListView>, MyPageProtocol {
    private let viewModel: CheckMyPartyViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        cellRegister()
        setTableViewDelegateAndDataSource()
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
            .subscribe(onNext: {owner, _ in
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

extension CheckMyPartyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = rootView.window?.windowScene?.screen.bounds.height
        return (height ?? 852.0) * 0.25
    }
}

extension CheckMyPartyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.myPartyList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
