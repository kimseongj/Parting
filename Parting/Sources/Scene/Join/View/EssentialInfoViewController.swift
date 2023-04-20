//
//  EssentialInfoViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/04/20.
//

import UIKit
import RxSwift
import RxCocoa

class EssentialInfoViewController: UIViewController {
    private let mainView = EssentialInfoView()
    private let viewModel: EssentialInfoViewModel
    
    init(viewModel: EssentialInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
    }
    
    private func navigationUI() {
        self.navigationController?.isNavigationBarHidden = false
        let leftBarButtonItem = UIBarButtonItem.init(image:  UIImage(named: "backBarButton"), style: .plain, target: self, action: #selector(backBarButtonClicked))
        leftBarButtonItem.tintColor = AppColor.joinText
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        let titleLabel = UILabel()
        titleLabel.text = "필수 정보 입력"
        titleLabel.textColor = AppColor.joinText
        titleLabel.textAlignment = .center
        titleLabel.font = notoSansFont.Regular.of(size: 20)
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
    }
    
    @objc func backBarButtonClicked() {
        self.viewModel.input.viewChangeTrigger.onNext(())
    }
}
