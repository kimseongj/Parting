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
    private var categoryTitle: [String] = []
    private var categoryDetailLists: [[String]] = []
    private var cellIdxList: [Int] = []
    

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
        cellResist()
        navigationUI()
        setDataSource()
        headerViewResist()
        bindingCategoryData()
        serviceStartButtonClicked()
        
        rootView.detailCategoryCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<String, String>(collectionView: self.rootView.detailCategoryCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = self.rootView.detailCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: detailCategoryCollectionViewCell.identifier, for: indexPath) as? detailCategoryCollectionViewCell else { return nil }
            cell.configure(itemIdentifier)
            return cell
        })
        
        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
            guard let view = self.rootView.detailCategoryCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CustomHeaderView.elementKind, for: indexPath) as? CustomHeaderView else { return UICollectionReusableView() }
        
            view.categoryLabel.text = self.categoryTitle[indexPath.section]
            
            return view
        }
    }
    
    private func serviceStartButtonClicked() {
        rootView.serviceStartButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.viewModel.input.naviagteToPublicScreenTrigger.onNext(())
            })
            .disposed(by: disposeBag)
    }
    
    private func bindingCategoryData() {
        self.viewModel.count
            .withUnretained(self)
            .subscribe(onNext: { owner, count in
                owner.cellIdxList = count
            })
            .disposed(by: disposeBag)
        
        self.viewModel.categoryNameList
            .withUnretained(self)
            .subscribe(onNext: { owner, data in
                owner.categoryTitle = data
            })
            .disposed(by: disposeBag)
        
        self.viewModel.associatedNameList
            .withUnretained(self)
            .subscribe(onNext: { owner, data in
                owner.categoryDetailLists = data
                owner.snapShotTest()
            })
            .disposed(by: disposeBag)
		
		rootView.serviceStartButton.rx.tap
			.bind(to: viewModel.input.naviagteToPublicScreenTrigger)
			.disposed(by: disposeBag)
        
//        Observable
//            .zip(rootView.detailCategoryCollectionView.rx.modelSelected(CategoryDetailResultContainisSelected.self), rootView.detailCategoryCollectionView.rx.itemSelected)
//            .subscribe(onNext: { [weak self] (item, indexPath) in
////                item.isClicked = false
//                item.isClicked.toggle()
//                print(item.isClicked, "✅")
//            })
//            .disposed(by: disposeBag)
    }
    
    private func headerViewResist() {
        self.rootView.detailCategoryCollectionView.register(CustomHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomHeaderView.elementKind)
    }
    
    private func cellResist() {
        self.rootView.detailCategoryCollectionView.register(detailCategoryCollectionViewCell.self, forCellWithReuseIdentifier: detailCategoryCollectionViewCell.identifier)
    }
    
    private func snapShotTest() {
        var snapshot = NSDiffableDataSourceSnapshot<String, String>()
        snapshot.appendSections(categoryTitle)
        
        for (idx,section) in snapshot.sectionIdentifiers.enumerated() {
            snapshot.appendItems(categoryDetailLists[idx], toSection: section)
        }
        
        self.dataSource?.apply(snapshot, animatingDifferences: true)
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

extension DetailInterestsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCategoryCollectionViewCell.identifier, for: indexPath) as? detailCategoryCollectionViewCell else { return }
        
        print(cell.isSelected, "✅")
    }
}


