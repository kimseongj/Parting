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

	private let disposeBag = DisposeBag()
	
	init(viewModel: PartyListViewModel, title: String) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		self.rootView.navigationLabel.text = title + "팟"
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationUI()
		bindViewModel()
		configureCell()
	}


	private func navigationUI() {
		navigationController?.isNavigationBarHidden = false
		self.navigationItem.rightBarButtonItem = rootView.bellBarButton
		self.navigationItem.leftBarButtonItem = rootView.backBarButton
		self.navigationItem.titleView = rootView.navigationLabel

	}

	private func configureCell() {
		rootView.partyListTableView.dataSource = self
		rootView.partyListTableView.delegate = self
	}

	private func bindViewModel() {
		rootView.backBarButton.innerButton
			.rx.tap.bind(to: viewModel.input.popVCTrigger)
			.disposed(by: disposeBag)
	}

}

extension PartyListViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = PartyTableViewCell()
		cell.selectionStyle = .none
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let height = rootView.window?.windowScene?.screen.bounds.height
		return (height ?? 852.0) * 0.25
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: PartyListHeaderView.identifier) as? PartyListHeaderView else { return UIView() }
		return header
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		let height = rootView.window?.windowScene?.screen.bounds.height
		return (height ?? 852.0) * 0.1
	}
	
}

