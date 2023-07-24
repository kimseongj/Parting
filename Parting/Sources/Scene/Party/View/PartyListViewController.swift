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

	init(viewModel: PartyListViewModel, title: String) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		self.rootView.navigationLabel.text = title + "팟"
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    
    deinit {
        print("PartyListVC 메모리해제")

    }

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationUI()
		bindViewModel()
		configureTableView()
	}


	private func navigationUI() {
		navigationController?.isNavigationBarHidden = false
		self.navigationItem.rightBarButtonItem = rootView.bellBarButton
		self.navigationItem.leftBarButtonItem = rootView.backBarButton
		self.navigationItem.titleView = rootView.navigationLabel

	}

	private func configureTableView() {

		rootView.partyListTableView.rx.setDelegate(self).disposed(by: disposeBag)
		rootView.partyListTableView.register(PartyTableViewCell.self, forCellReuseIdentifier: PartyTableViewCell.identifier)
		rootView.partyListTableView.register(PartyListHeaderView.self, forHeaderFooterViewReuseIdentifier: PartyListHeaderView.identifier)
	}

	private func bindViewModel() {
		rootView.backBarButton.innerButton
			.rx.tap.bind(to: viewModel.input.popVCTrigger)
			.disposed(by: disposeBag)
		rootView.fab
			.rx.tap.bind(to: viewModel.input.pushCreatePartyVCTrigger)
			.disposed(by: disposeBag)
		
		viewModel.output.partyList.bind(to: rootView.partyListTableView.rx.items(cellIdentifier: PartyTableViewCell.identifier, cellType: PartyTableViewCell.self)) { index, party, cell in
			cell.selectionStyle = .none
			cell.configureCell(party: party)
		}.disposed(by: disposeBag)
		
		
	}

}

extension PartyListViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let height = rootView.window?.windowScene?.screen.bounds.height
		return (height ?? 852.0) * 0.25
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: PartyListHeaderView.identifier) as? PartyListHeaderView else { return UITableViewHeaderFooterView() }
		return header
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		let height = rootView.window?.windowScene?.screen.bounds.height
		return (height ?? 852.0) * 0.1
	}
	
}

