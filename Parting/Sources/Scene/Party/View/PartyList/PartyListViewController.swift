//
//  PartyListViewController.swift
//  Parting
//
//  Created by 김민규 on 2023/07/11.
//


import UIKit

import RxSwift
import Kingfisher

class PartyListViewController: BaseViewController<PartyListView> {
    private var viewModel: PartyListViewModel
    
    private var tableViewReachedEndCount = 0
    
    init(viewModel: PartyListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.input.viewWillAppear.onNext(())
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
        self.viewModel.input.viewDidLoad.onNext(())
    }
    
    
    private func navigationUI() {
        navigationController?.isNavigationBarHidden = false
    }
    
    private func configureTableView() {
        rootView.partyListTableView.rx.setDelegate(self).disposed(by: disposeBag)
        rootView.partyListTableView.register(PartyTableViewCell.self, forCellReuseIdentifier: PartyTableViewCell.identifier)
        rootView.partyListTableView.register(PartyListHeaderView.self, forHeaderFooterViewReuseIdentifier: PartyListHeaderView.identifier)
        rootView.partyListTableView.sectionHeaderHeight = 35
        rootView.partyListTableView.sectionHeaderTopPadding = 5
    }
    
    private func bindViewModel() {
        viewModel.output.reloadData
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.rootView.partyListTableView.reloadData()
            })
            .disposed(by: disposeBag)
        rootView.addButton
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: PartyListHeaderView.identifier) else { return UIView() }
        return headerView
    }
}
