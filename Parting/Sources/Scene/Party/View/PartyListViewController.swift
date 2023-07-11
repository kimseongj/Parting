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
	}


	private func navigationUI() {
		navigationController?.isNavigationBarHidden = false
		self.navigationItem.rightBarButtonItem = rootView.bellBarButton
		self.navigationItem.leftBarButtonItem = rootView.backBarButton
		self.navigationItem.titleView = rootView.navigationLabel

	}



	private func bindViewModel() {
		rootView.backBarButton.innerButton
			.rx.tap.bind(to: viewModel.input.popVCTrigger)
			.disposed(by: disposeBag)
	}

}

extension PartyListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
	
	
}

