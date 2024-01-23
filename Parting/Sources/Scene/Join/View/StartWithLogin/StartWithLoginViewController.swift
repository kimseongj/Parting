//
//  StartWithLoginViewController.swift
//  Parting
//
//  Created by kimseongjun on 1/14/24.
//

import UIKit
import RxSwift
import RxCocoa

final class StartWithLoginViewController: BaseViewController<StartWithLoginView> {
    
    weak var coordinator: JoinCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideBackBarButton()
        configureNexButton()
    }
    
    func receive(coordinator: JoinCoordinator) {
        self.coordinator = coordinator
    }
    
    func hideBackBarButton() {
        navigationItem.hidesBackButton = true
    }
    
    func configureNexButton() {
        rootView.nextStepButton.addTarget(self, action: #selector(tapNextButton), for: .touchUpInside)
    }
    
    @objc
    private func tapNextButton() {
        coordinator?.connectTabBarCoordinator()
    }
}
