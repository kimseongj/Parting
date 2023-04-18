//
//  AppCoordinator.swift
//  Parting
//
//  Created by 박시현 on 2023/04/17.
//

import UIKit

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
        connectJoinFlow()
    }

    private func connectJoinFlow() {
        let joinCoordinator = JoinCoordinator(self.navigationController)
        joinCoordinator.delegate = self
        joinCoordinator.start()
        childCoordinators.append(joinCoordinator)
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

