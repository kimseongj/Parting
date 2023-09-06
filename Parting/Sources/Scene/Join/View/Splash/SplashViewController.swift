//
//  SplashViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/04/17.
//

import UIKit
import RxSwift
import RxCocoa

class SplashViewController: BaseViewController<SplashView>, CoordinatorDelegate {
    func didFinish(childCoordinator: Coordinator) {
        print("didfinish")
    }
    
    private var viewModel: SplashViewModel
    private var 로그인여부: Bool = true
    var navigation: UINavigationController
    var childCoordinators = [Coordinator]()
    
    init(viewModel: SplashViewModel, _ navigationController: UINavigationController) {
		self.viewModel = viewModel
        self.navigation = navigationController
        navigation.setNavigationBarHidden(true, animated: false)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("SplashView 메모리해제")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.input.viewDidLoadTrigger.onNext(())
    }
    
    private func backgroundUI() {
        rootView.setGradient(UIColor(hexcode: "FFEAD4"), AppColor.brand)
    }
}
