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

    func start() {
		if isLoggedIn {
			connectMainFlow()
		} else {
			connectJoinFlow()
		}
    }

    private func connectJoinFlow() {
        let joinCoordinator = JoinCoordinator(self.navigationController)
        joinCoordinator.delegate = self
		print(joinCoordinator.delegate)
        joinCoordinator.start()
        childCoordinators.append(joinCoordinator)
    }
	
	func connectMainFlow() {
		let mainCoordinator = TabCoordinator(self.navigationController)
		mainCoordinator.delegate = self
		mainCoordinator.start()
		childCoordinators.append(mainCoordinator)
    }
	

	
	
}

extension AppCoordinator: CoordinatorDelegate {

    func didFinish(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter({ $0.type != childCoordinator.type })

        //self.navigationController.view.backgroundColor = .systemBackground
        self.navigationController.viewControllers.removeAll()

        switch childCoordinator.type {
        case .join:
			self.connectJoinFlow()
        default:
            break
        }
    }
}

// MARK: Authentication
extension AppCoordinator {
	var isLoggedIn: Bool {
		// Check if user has logged in using key chain
		return false
	}
}

