//
//  SplashViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/04/17.
//

import UIKit

class SplashViewController: UIViewController {
    private let mainView = SplashView()
    private var viewModel: SplashViewModel
    
    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundUI()
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.viewModel.showJoinViewController()
        }
    }
    private func backgroundUI() {
        mainView.setGradient(UIColor(hexcode: "FFEAD4"), AppColor.brand)
    }
}
