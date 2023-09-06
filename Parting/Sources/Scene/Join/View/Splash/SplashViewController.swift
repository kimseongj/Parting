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
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.input.viewDidLoadTrigger.onNext(())
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            if self.로그인여부 { // 로그인 되었다고 가정 => 나중에 토큰으로 판단
                let mainCoordinator = TabCoordinator(self.navigation)
                mainCoordinator.delegate = self
                mainCoordinator.start()
                self.childCoordinators.append(mainCoordinator)
            } else {
                (self.viewModel as! SplashViewModel).showJoinViewController()
            }
            
        }
        print(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print(#function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(#function)
    }
    
    private func backgroundUI() {
        rootView.setGradient(UIColor(hexcode: "FFEAD4"), AppColor.brand)
    }
    
    func bind() {
        viewModel.output.calendarDays
            .withUnretained(self)
            .subscribe(onNext: { owner, data in
            })
            .disposed(by: disposeBag)
    }
    
}
