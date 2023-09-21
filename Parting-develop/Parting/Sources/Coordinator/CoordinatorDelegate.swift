//
//  CoordinatorDelegate.swift
//  Parting
//
//  Created by 박시현 on 2023/04/17.
//

import Foundation

protocol CoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}
