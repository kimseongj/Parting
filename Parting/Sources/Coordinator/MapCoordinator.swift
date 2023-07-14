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
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMapVC()
    }
    
    func showMapVC() {
        let viewModel = MapViewModel(mapCoordinator: self)
        let vc = MapViewController()
    }
    
}

