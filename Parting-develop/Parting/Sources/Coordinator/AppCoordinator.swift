//
//  AppCoordinator.swift
//  Parting
//
//  Created by 박시현 on 2023/04/17.
//

import UIKit

final class AppCoordinator: Coordinator {

    weak var delegate: CoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .app
    
    private let userDefaults = UserDefaults.standard

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func checkLogin(isLogin: Bool) {
        if isLogin { // 로그인이 이미 되어있는 경우
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let mainCoordinator = TabCoordinator(self.navigationController)
                mainCoordinator.delegate = self
                mainCoordinator.start()
                self.childCoordinators.append(mainCoordinator)
            }
        } else { // 로그인이 안되어 있는 경우
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let joinCoordinator = JoinCoordinator(self.navigationController)
                joinCoordinator.delegate = self
                joinCoordinator.start()
                self.childCoordinators.append(joinCoordinator)
            }
        }
    }

    func start() {
        let viewModel = SplashViewModel(coordinator: self)
        let vc = SplashViewController(viewModel: viewModel, navigationController)
        navigationController.pushViewController(vc, animated: true)
    }
}

extension AppCoordinator: CoordinatorDelegate {

    func didFinish(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter({ $0.type != childCoordinator.type })
        
        self.navigationController.viewControllers.removeAll()
    }
}

// MARK: Authentication
extension AppCoordinator {
	var isLoggedIn: Bool {
		// Check if user has logged in using key chain
		return false
	}
}

