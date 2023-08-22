//
//  MyPageCoordinator.swift
//  Parting
//
//  Created by 박시현 on 2023/07/13.
//

import UIKit

protocol MyPageCoordinatorProtocol: Coordinator {
    //MARK: - MyPage에 해당하는 기능 프로토콜
    
    var MyPageViewController: MyPageViewController { get set }
}

final class MyPageCoordinator: Coordinator {
    weak var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = .init()
    var type: CoordinatorStyleCase = .tab
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMyPageVC()
    }
    
    func popVC() {
        navigationController.popViewController(animated: true)
    }
    
    func showMyPageVC() {
        let viewModel = MyPageViewModel(coordinator: self)
        let vc = MyPageViewController(viewModel: viewModel)
        navigationController.viewControllers = [vc]
    }
    
    func pushRecentlyPartyVC() {
        let viewModel = RecentlyPartyViewModel(myPageCoordinator: self)
        let vc = RecentlyPartyViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushMyPartyVC() {
        let viewModel = CheckMyPartyViewModel(coordinator: self)
        let vc = CheckMyPartyViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
