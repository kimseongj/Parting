//
//  DetailInterestsViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/06/10.
//

import UIKit
import RxSwift
import RxCocoa

class DetailInterestsViewController: BaseViewController<DetailInterestsView> {
    static let sectionBackgroundDecorationElementKind = "background"
    private let viewModel: DetailInterestsViewModel
    
    var dataSource: UICollectionViewDiffableDataSource<String, String>?
    
    init(viewModel: DetailInterestsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("DetailInterestsVC 메모리 해제")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        bindDetailCategory()
        bindButtonState()
        serviceStartButtonClicked()
        viewModel.getAssociatedCategory()
    }
    
    private func serviceStartButtonClicked() {
        rootView.serviceStartButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.viewModel.postDetailInterests()
                owner.viewModel.input.pushStartWithLoginViewTrigger.onNext(())
            })
            .disposed(by: disposeBag)
    }
    
    private func bindDetailCategory() {
        viewModel.output.categoryDictionaryRelay.bind(onNext: { [weak self] categoryDictionary in
            guard let self = self else { return }
            
            for (title, categoryDetails) in categoryDictionary {
                let detailInterestsListView = self.rootView.makeDetailInterestsListView(title: title, categoryDetailList: categoryDetails)
                detailInterestsListView.detailCategoryCollectionView.rx.itemSelected.observe(on: MainScheduler.instance).withUnretained(self).subscribe(onNext: { owner, indexPath in
                    let id = categoryDetails[indexPath.row].categoryDetailID
                    owner.viewModel.addSelectedDetailCategoryID(id)
                    
                    guard let cell = detailInterestsListView.detailCategoryCollectionView.cellForItem(at: indexPath) as? DetailCategoryCollectionViewCell else { return }
                    cell.changeCellState(true)
                })
                .disposed(by: disposeBag)
                
                detailInterestsListView.detailCategoryCollectionView.rx.itemDeselected.observe(on: MainScheduler.instance).withUnretained(self).subscribe(onNext: { owner, indexPath in
                    let id = categoryDetails[indexPath.row].categoryDetailID
                    owner.viewModel.removeSelectedDetailCategoryID(id)
                    
                    guard let cell = detailInterestsListView.detailCategoryCollectionView.cellForItem(at: indexPath) as? DetailCategoryCollectionViewCell else { return }
                    cell.changeCellState(false)
                })
                .disposed(by: disposeBag)
            }
        })
        .disposed(by: disposeBag)
    }
    
    private func bindButtonState() {
        viewModel.output.selectedDetailCategoryIDListRelay.subscribe(onNext: { [weak self] indexList in
            guard let self = self else { return }
            
            if indexList.count > 0 {
                self.rootView.changeCompleteButtonColor(state: true)
            } else {
                self.rootView.changeCompleteButtonColor(state: false)
            }
        })
        .disposed(by: disposeBag)
    }
    
    private func navigationUI() {
        self.navigationController?.isNavigationBarHidden = false
        let leftBarButtonItem = UIBarButtonItem.init(image:  UIImage(named: "backBarButton"), style: .plain, target: self, action: #selector(backBarButtonClicked))
        leftBarButtonItem.tintColor = AppColor.joinText
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        let titleImage = UIImage(named: "JoinFlowDetailinterest")
        navigationItem.titleView = UIImageView(image: titleImage)
    }
    
    @objc func backBarButtonClicked() {
        self.viewModel.input.popDetailInterestsViewTrigger.onNext(())
    }
}
