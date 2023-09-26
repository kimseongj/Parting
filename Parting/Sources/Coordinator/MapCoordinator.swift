//
//  MapCoordinator.swift
//  Parting
//
//  Created by 박시현 on 2023/07/14.
//

import UIKit

protocol MapCoordinatorProtocol: Coordinator {
    //MARK: - MyPage에 해당하는 기능 프로토콜
    
    var MapViewController: MapViewController { get set }
}

final class MapCoordinator: Coordinator {
    weak var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = .init()
    var type: CoordinatorStyleCase = .tab
    weak var currentVC: UIViewController?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMapVC()
    }
    
    func showMapVC() {
        let viewModel = MapViewModel(mapCoordinator: self)
        let vc = MapViewController(viewModel: viewModel)
        currentVC = vc
        navigationController.viewControllers = [vc]
    }
    
    func showPartyDetailBottomsheetVC(data: AroundPartyDetailResponse) {
        let viewModel = BottomSheetViewModel(coorinator: self, data: data)
        let vc = BottomSheetViewController(viewModel: viewModel)
        if let currentVC = currentVC as? MapViewController {
            currentVC.present(vc, animated: true)
        }
    }
    
    func dismissPartyDetailBottomSheetVC() {
        currentVC?.dismiss(animated: true)
    }
}

