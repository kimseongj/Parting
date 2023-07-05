//
//  HomeViewController.swift
//  Parting
//
//  Created by 김민규 on 2023/05/09.
//

import Foundation
import UIKit
import RxSwift

class HomeViewController: BaseViewController<HomeView> {
	
	private var viewModel: HomeViewModel
	
	private let disposeBag = DisposeBag()
	
	init(viewModel: HomeViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationUI()
		bindViewModel()
		APIManager.shared.getCategoryAPI()
	}
	
	private func navigationUI() {
		navigationController?.isNavigationBarHidden = false
		self.navigationItem.rightBarButtonItem = rootView.bellBarButton
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: rootView.navigationLabel)
		

	}
	
	
	private func bindViewModel() {
		rootView.calendarWidget.rx.tap
			.bind(to: viewModel.input.pushScheduleVCTrigger)
			.disposed(by: disposeBag)
		
	}
	
}



