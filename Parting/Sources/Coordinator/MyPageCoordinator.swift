//
//  MyPageCoordinator.swift
//  Parting
//
//  Created by 박시현 on 2023/07/13.
//

import UIKit

final class MyPageCoordinator: Coordinator {
    var delegate: CoordinatorDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator]
    
    var type: CoordinatorStyleCase
    
    func start() {
        <#code#>
    }
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
}
