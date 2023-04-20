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
        showSplashViewController()
    }
    
    func showSplashViewController() {
        let viewModel = SplashViewModel(coordinator: self)
        let vc = SplashViewController(viewModel: viewModel)
        navigationController.viewControllers = [vc]
    }
    
    func showJoinViewController() {
        let viewModel = JoinViewModel(coordinator: self)
        let vc = JoinViewController(viewModel: viewModel)
        changeAnimation()
        navigationController.viewControllers = [vc]
    }
    
    func pushJoinCompleteViewController() {
        let viewModel = JoinCompleteViewModel(coordinator: self)
        let vc = JoinCompleteViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func popJoinCompleteViewController() {
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
}
