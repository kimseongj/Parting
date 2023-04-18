//
//  JoinViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/04/15.
//

import UIKit
import RxSwift
class JoinViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var viewModel: JoinViewModel
    private let mainView = JoinView()
    
    override func loadView() {
        self.view = mainView
    }
    
    init(viewModel: JoinViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView.setGradient(UIColor(hexcode: "FFEAD4"), AppColor.brand)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager.shared.testAPI()
            .subscribe(onNext: {[weak self] datas in
                print(datas)
            })
            .disposed(by: disposeBag)

    }
    
    
    
    
}
