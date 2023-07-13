//
//  ScheduleViewController.swift
//  Parting
//
//  Created by 김민규 on 2023/07/01.
//

import Foundation
import UIKit
import RxSwift
import FSCalendar

class ScheduleViewController: BaseViewController<ScheduleView> {

	private var viewModel: ScheduleViewModel

	private let disposeBag = DisposeBag()
	
	
	
	init(viewModel: ScheduleViewModel) {
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
		
	}

	private func navigationUI() {
		navigationController?.isNavigationBarHidden = false
		self.navigationItem.rightBarButtonItem = rootView.bellBarButton
		self.navigationItem.leftBarButtonItem = rootView.backBarButton
		self.navigationItem.titleView = rootView.titleView
	}


	private func bindViewModel() {
		
		rootView.backBarButton.innerButton.rx.tap
			.bind(to: viewModel.input.popVCTrigger)
			.disposed(by: disposeBag)

	}

}



