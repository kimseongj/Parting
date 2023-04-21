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
    
    override func viewDidLayoutSubviews() {
        checkButtonUI()
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
    
    private func checkButtonUI() {
        mainView.checkJobFirstStackView.checkButton.layer.cornerRadius = mainView.checkJobFirstStackView.checkButton.bounds.size.width / 2
        mainView.checkJobFirstStackView.checkButton.clipsToBounds = true
        mainView.checkJobFirstStackView.checkButton.setImage(UIImage(named: "checkButton"), for: .normal)
        mainView.checkJobFirstStackView.checkAnswerLabel.text = "네, 직장인입니다."
        
        
        mainView.checkJobSecondStackView.checkButton.layer.cornerRadius = mainView.checkJobSecondStackView.checkButton.bounds.size.width / 2
        mainView.checkJobSecondStackView.checkButton.clipsToBounds = true
        mainView.checkJobSecondStackView.checkButton.setImage(UIImage(named: "checkButton"), for: .normal)
        mainView.checkJobSecondStackView.checkAnswerLabel.text = "아니오, 학생입니다."
        
        
        mainView.checkGenderFirstStackView.checkButton.layer.cornerRadius = mainView.checkGenderFirstStackView.checkButton.bounds.size.width / 2
        mainView.checkGenderFirstStackView.checkButton.clipsToBounds = true
        mainView.checkGenderFirstStackView.checkButton.setImage(UIImage(named: "checkButton"), for: .normal)
        mainView.checkGenderFirstStackView.checkAnswerLabel.text = "남자"
        
        mainView.checkGenderSecondStackView.checkButton.layer.cornerRadius = mainView.checkGenderSecondStackView.checkButton.bounds.size.width / 2
        mainView.checkGenderSecondStackView.checkButton.clipsToBounds = true
        mainView.checkGenderSecondStackView.checkButton.setImage(UIImage(named: "checkButton"), for: .normal)
        mainView.checkGenderSecondStackView.checkAnswerLabel.text = "여자"
    }
    
    @objc func backBarButtonClicked() {
        self.viewModel.input.viewChangeTrigger.onNext(())
    }
}
