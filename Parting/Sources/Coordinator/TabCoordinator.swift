//
//  TabCoordinator.swift
//  Parting
//
//  Created by 김민규 on 2023/07/01.
//

import Foundation
import UIKit
// Reference: https://somevitalyz123.medium.com/coordinator-pattern-with-tab-bar-controller-33e08d39d7d
// Ref 2: https://labs.brandi.co.kr/2020/06/16/kimjh.html

class TabCoordinator:  NSObject, Coordinator {
	var delegate: CoordinatorDelegate?
	var navigationController: UINavigationController
	var tabBarController: UITabBarController
	var childCoordinators: [Coordinator] = []
	var type: CoordinatorStyleCase = .tab
	
	required init(_ navigationController: UINavigationController) {
		self.navigationController = navigationController
        self.tabBarController = .init()
	}
	
	func start() {
		startChildCoordinators()
		prepareTabBarController(withSubCoordinator: childCoordinators)
		setupTabBar()
	}
	
	private func startChildCoordinators() {
		let homeCoordinator = HomeCoordinator(StyledNavigationController())
		homeCoordinator.start()
		childCoordinators.append(homeCoordinator)
        
        let myPageCoordinator = MyPageCoordinator(StyledNavigationController())
        myPageCoordinator.start()
        childCoordinators.append(myPageCoordinator)
        
        let mapCoordinator = MapCoordinator(StyledNavigationController())
        mapCoordinator.start()
        childCoordinators.append(mapCoordinator)
    
	}
	
	
	private func prepareTabBarController(withSubCoordinator subCoordinators: [Coordinator]) {
		
		let tabControllers = subCoordinators.map({ coordinator in
			return coordinator.navigationController
		})
		
		tabBarController.setViewControllers(tabControllers, animated: true)
		tabBarController.selectedIndex = 0
		tabBarController.tabBar.isTranslucent = false
		navigationController.viewControllers = [tabBarController]
	}
	
	private func setupTabBar() {
		tabBarController.tabBar.tintColor = AppColor.baseText
		tabBarController.tabBar.backgroundColor = AppColor.white
		if let items = tabBarController.tabBar.items {
			items[0].selectedImage = .init(named: Images.icon.home)
			items[0].image = .init(named: Images.icon.home)
            
            items[1].selectedImage = .init(named: Images.icon.compass)
            items[1].image = .init(named: Images.icon.compass)
            
            items[2].selectedImage = .init(named: Images.icon.profile)
            items[2].image = .init(named: Images.icon.profile)
		}
	}
}




