//
//  InterestsViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/04/20.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class InterestsViewController: BaseViewController<InterestsView> {
    private let viewModel: InterestsViewModel

    init(viewModel: InterestsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("InterestsVC 메모리 해제")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        configureCell()
        bindCategory()
        bindNextButtonState()
        didSelectedCell()
        didDeselectedCell()
        nextButtonClicked()
        viewModel.getCategoryInfo()
    }
    
    private func configureCell() {
        rootView.categoryCollectionView.register(CategoryImageCollectionViewCell.self, forCellWithReuseIdentifier: CategoryImageCollectionViewCell.identifier)
    }
    
    private func bindCategory() {
        viewModel.output.categoryRelay
            .bind(to: rootView.categoryCollectionView.rx.items(cellIdentifier: CategoryImageCollectionViewCell.identifier, cellType: CategoryImageCollectionViewCell.self)) {
                index, categoryData, cell in
                cell.configureCell1(name: categoryData.name)
            }
            .disposed(by: disposeBag)
    }
    
    private func didSelectedCell() {
        rootView.categoryCollectionView.rx
            .itemSelected
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { owner, indexPath in
                guard let cell = owner.rootView.categoryCollectionView.cellForItem(at: indexPath) as? CategoryImageCollectionViewCell else { return }
                cell.interestsLabel.textColor = AppColor.gray900
                cell.imageBgView.layer.borderColor = UIColor(hexcode: "FBB0C0").cgColor
                
                owner.viewModel.addSelected(index: indexPath.row)
            })
            .disposed(by: disposeBag)
    }
    
    private func didDeselectedCell() {
        rootView.categoryCollectionView.rx
            .itemDeselected
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { owner, indexPath in
                guard let cell = owner.rootView.categoryCollectionView.cellForItem(at: indexPath) as? CategoryImageCollectionViewCell else { return }
                cell.interestsLabel.textColor = AppColor.gray700
                cell.imageBgView.layer.borderColor = UIColor(hexcode: "F1F1F1").cgColor
                
                owner.viewModel.removeSelected(index: indexPath.row)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindNextButtonState() {
        viewModel.output.selectedIDRelay.subscribe(onNext: { [weak self] indexList in
            guard let self = self else { return }
            
            if indexList.count > 0 {
                self.rootView.changeButtonColor(state: true)
            } else {
                self.rootView.changeButtonColor(state: false)
            }
        })
        .disposed(by: disposeBag)
    }
    
    private func nextButtonClicked() {
        rootView.nextStepButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                if owner.viewModel.selectedIDList.count > 0 {
                    owner.viewModel.input.pushDetailInterestViewTrigger.onNext(owner.viewModel.selectedIDList)
                } else {
                    print("선택한 카테고리가 없습니다.")
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func navigationUI() {
        self.navigationController?.isNavigationBarHidden = false
        let leftBarButtonItem = UIBarButtonItem.init(image:  UIImage(named: "backBarButton"), style: .plain, target: self, action: #selector(backBarButtonClicked))
        leftBarButtonItem.tintColor = AppColor.joinText
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        let titleImage = UIImage(named: "JoinFlowInterest")
        navigationItem.titleView = UIImageView(image: titleImage)
    }
    
    @objc func backBarButtonClicked() {
        self.viewModel.input.popInterestsViewTrigger.onNext(())
    }
}
