//
//  HomeCoordinator.swift
//  Parting
//
//  Created by 김민규 on 2023/05/09.
//

import UIKit

final class HomeCoordinator: Coordinator {
	weak var delegate: CoordinatorDelegate?
	var childCoordinators = [Coordinator]()
	var navigationController: UINavigationController
	var type: CoordinatorStyleCase = .home
	
	init(_ navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start() {
		showHomeViewController()
	}
	
	func showHomeViewController() {
		let viewModel = HomeViewModel(coordinator: self)
		let vc = HomeViewController(viewModel: viewModel)
		navigationController.viewControllers = [vc]
	}
	
	
	
}
