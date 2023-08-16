//
//  MyPageViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/07/13.
//

import UIKit
import RxSwift
import RxCocoa

final class MyPageViewController: BaseViewController<MyPageView> {
    
    private var viewModel: MyPageViewModel
    
    init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
    }
    
    private func navigationUI() {
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: rootView.navigationLabel)
    }
}
