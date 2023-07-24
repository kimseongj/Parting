//
//  HomeCoordinator.swift
//  Parting
//
//  Created by 김민규 on 2023/05/09.
//

import UIKit

final class HomeCoordinator: Coordinator {
	
	weak var delegate: CoordinatorDelegate?
    var childCoordinators: [Coordinator] = .init()
	var navigationController: UINavigationController
	var type: CoordinatorStyleCase = .home
	
	init(_ navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start() {
		showHomeVC()
	}
	
	func showHomeVC() {
		let viewModel = HomeViewModel(coordinator: self)
		let vc = HomeViewController(viewModel: viewModel)

		navigationController.viewControllers = [vc]
	}
	
	func pushScheduleVC() {
		let viewModel = ScheduleViewModel(coordinator: self)
		navigationController.pushViewController(ScheduleViewController(viewModel: viewModel), animated: true)
	}
		
	func pushPartyListVC(category: CategoryModel) {
		let viewModel = PartyListViewModel(coordinator: self, category: category)
		navigationController.pushViewController(PartyListViewController(viewModel: viewModel, title: category.name), animated: true)
	}
	
	func pushCreatePartyVC() {
        let viewModel = CreatePartyViewModel(coordinator: self)
		navigationController.pushViewController(CreatePartyViewController(viewModel: viewModel), animated: true)
	}
	
	func popVC() {
		navigationController.popViewController(animated: true)
	}
	

	
}
