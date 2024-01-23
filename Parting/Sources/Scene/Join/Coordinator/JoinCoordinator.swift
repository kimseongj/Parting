//
//  JoinCoordinator.swift
//  Parting
//
//  Created by 박시현 on 2023/04/17.
//

import UIKit

final class JoinCoordinator: Coordinator {
    weak var delegate: CoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .join
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showJoinViewController()
    }
    
    func connectTabBarCoordinator() {
        let tabBarCoordinator = TabCoordinator(self.navigationController)
        tabBarCoordinator.start()
        self.childCoordinators.append(tabBarCoordinator)
    }
    
    func showJoinViewController() {
        let viewModel = JoinViewModel(coordinator: self)
        let vc = JoinViewController(viewModel: viewModel)
        print(self, "coordi")
        changeAnimation()
        navigationController.viewControllers = [vc]
        print(self, "coordi")

    }
    
    func pushUserAgreementViewController() {
        let viewModel = UserAgreementViewModel(coordinator: self)
        let vc = UserAgreementViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func popUserAgreementVC() {
        navigationController.popViewController(animated: true)
    }
    
    func pushEssentialInfoViewController() {
        let viewModel = EssentialInfoViewModel(coordinator: self)
        let vc = EssentialInfoViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func popEssentialInfoViewController() {
        navigationController.popViewController(animated: true)
    }
    
    func pushInterestsViewController() {
        let viewModel = InterestsViewModel(coordinator: self)
        let vc = InterestsViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func popInterestsViewController() {
        navigationController.popViewController(animated: true)
    }
    
    func pushDeteilInterestsViewController(categoryIDList: [String]) {
        let viewModel = DetailInterestsViewModel(coordinator: self, categoryIDList: categoryIDList)
        let vc = DetailInterestsViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func popDetailInterestsViewController() {
        navigationController.popViewController(animated: true)
    }
    
    func pushStartWithLoginViewController() {
        let vc = StartWithLoginViewController()
        vc.receive(coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func popStartWithLoginViewController() {
        navigationController.popViewController(animated: true)
    }
}

extension JoinCoordinator: CoordinatorDelegate {
    func didFinish(childCoordinator: Coordinator) {
        print("didFinish")
    }
}
