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
    weak var currentVC: UIViewController?
    
    init(_ navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
    deinit {
        print("HomeCoordi 메모리해제")
    }
    
    func start() {
		showHomeVC()
	}
    
    func popVC() {
        navigationController.popViewController(animated: true)
    }
	
    func showHomeVC() {
        navigationController.viewControllers = []
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
        let vc1 = PartyListViewController(viewModel: viewModel, title: category.name)
        let vc2 = PartyListViewController(viewModel: viewModel, title: category.name)
        let vc3 = PartyListViewController(viewModel: viewModel, title: category.name)
        
        let tabManViewModel = TabManViewModel(coordinator: self)

        let tabManVC = TabManViewController(
            firstVC: vc1,
            secondVC: vc2,
            thirdVC: vc3,
            title: category.name,
            viewModel: tabManViewModel
        )
		navigationController.pushViewController(tabManVC, animated: true)
	}
	
	func pushCreatePartyVC() {
        let viewModel = CreatePartyViewModel(coordinator: self)
        let vc = CreatePartyViewController(viewModel: viewModel)
        currentVC = vc
		navigationController.pushViewController(vc, animated: true)
	}
	
    func pushSetMapVC() {
        let viewModel = SetMapViewModel(coordinator: self)
        let vc = SetMapViewController(viewModel: viewModel)
        if let currentVC = currentVC as? CreatePartyViewController {
            vc.delegate = currentVC
        }
        navigationController.pushViewController(vc, animated: true)
    }
    
    func presentPopUpVC() {
        let viewModel = SetPopUpViewModel(coordinator: self)
        let vc = SetPopUpViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
    
    func dismissPopUpVC() {
        navigationController.dismiss(animated: true)
    }
    
    func pushDetailPartyVC(partyId: Int) {
        let viewModel = PartyDetailInfoViewModel(coordinator: nil, partyId: partyId, homeCoordinator: self)
        let vc = PartyDetailInfoViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}
