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
    
    func pushMyPartyVC(responseData: CheckMyPartyResponse) {
        let viewModel = CheckMyPartyViewModel(coordinator: self, responseData: responseData)
        let vc = CheckMyPartyViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushEnteredPartyVC(responseData: CheckMyPartyResponse) {
        let viewModel = EnterPartyViewModel(coordinator: self, responseData: responseData)
        let vc = EnterPartyViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushDetailPartyVC(partyId: Int) {
        let viewModel = PartyDetailInfoViewModel(coordinator: self, partyId: partyId, homeCoordinator: nil)
        let vc = PartyDetailInfoViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushEditMyPageVC() {
        let viewModel = EditMyPageViewModel(coordinator: self)
        let vc = EditMyPageViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func presentNotificationSettingVC() {
        let viewModel = NotificationSettingViewModel(coordinator: self)
        let vc = NotificationSettingViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
    
    func presentLogoutAlertVC() {
        let viewModel = LogoutAlertViewModel(coordinator: self)
        let vc = LogoutAlertViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
    
    func dismissVC() {
        navigationController.dismiss(animated: true)
    }
    
    func pushInquireVC() {
        let viewModel = InquireViewModel(coordinator: self)
        let vc = InquireViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}
