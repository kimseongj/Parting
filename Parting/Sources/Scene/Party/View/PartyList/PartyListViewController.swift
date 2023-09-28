//
//  PartyListViewController.swift
//  Parting
//
//  Created by 김민규 on 2023/07/11.
//

import Foundation
import UIKit
import RxSwift
import Kingfisher

class PartyListViewController: BaseViewController<PartyListView> {
    
    private var viewModel: PartyListViewModel
    
    private var tableViewReachedEndCount = 0
    
    init(viewModel: PartyListViewModel, title: String) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.rootView.navigationLabel.text = title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.partyListTableView.reloadData()
        self.viewModel.loadPartyList()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("PartyListVC 메모리 해제")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        bindViewModel()
        configureTableView()
        self.viewModel.loadPartyList()
    }
    
    
    private func navigationUI() {
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = rootView.backBarButton
        self.navigationItem.titleView = rootView.navigationLabel
        rootView.navigationLabel.textAlignment = .left
        
    }
    
    private func configureTableView() {
        rootView.partyListTableView.rx.setDelegate(self).disposed(by: disposeBag)
        rootView.partyListTableView.register(PartyTableViewCell.self, forCellReuseIdentifier: PartyTableViewCell.identifier)
    }
    
    private func bindViewModel() {
        rootView.backBarButton.innerButton
            .rx.tap.bind(to: viewModel.input.popVCTrigger)
            .disposed(by: disposeBag)
        rootView.fab
            .rx.tap.bind(to: viewModel.input.pushCreatePartyVCTrigger)
            .disposed(by: disposeBag)
        
        viewModel.output.partyList.bind(to: rootView.partyListTableView.rx.items(cellIdentifier: PartyTableViewCell.identifier, cellType: PartyTableViewCell.self)) { [weak self] index, party, cell in
            cell.selectionStyle = .none
            cell.configurePartyListeCell(party: party)
        }.disposed(by: disposeBag)
        
        rootView.partyListTableView.rx
            .modelSelected(PartyListItemModel.self)
            .withUnretained(self)
            .subscribe(onNext: { owner, cellModel in
                owner.viewModel.input.didSelectCell.onNext(cellModel.id)
                print(cellModel.id, "🥰")
            })
            .disposed(by: disposeBag)
        
    }
    
}

// MARK: Table View
extension PartyListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
}

