//
//  HomeViewController.swift
//  Parting
//
//  Created by 김민규 on 2023/05/09.
//

import Foundation
import UIKit

class HomeViewController: BaseViewController<HomeView> {
	
	private var viewModel: HomeViewModel
	
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
		
	}
	
	private func navigationUI() {
		navigationController?.isNavigationBarHidden = false
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rootView.bellButton)
	}
	
}
