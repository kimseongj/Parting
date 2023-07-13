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
    private let disposeBag = DisposeBag()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellResist()
        navigationUI()
        setDataSource()
        headerViewResist()
        bindingCategoryData()
        serviceStartButtonClicked()
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
            .subscribe(onNext: {[weak self] _ in
                guard let self else { return }
                self.viewModel.input.pushHomeViewControllerTrigger.onNext(())
            })
            .disposed(by: disposeBag)
    }
    
    private func bindingCategoryData() {
        self.viewModel.count
            .subscribe(onNext: {[weak self] count in
                self?.cellIdxList = count
                print("CellList의 갯수는 \(count)야")
            })
            .disposed(by: disposeBag)
        
        self.viewModel.categoryNameList
            .subscribe(onNext: {[weak self] data in
                self?.categoryTitle = data
                var snapShotTestArr = data
                print("이건 categoryNameList야 \(snapShotTestArr)")
            })
            .disposed(by: disposeBag)
        
        self.viewModel.associatedNameList
            .subscribe(onNext: {[weak self] data in
                self?.categoryDetailLists = data
                self?.snapShotTest()
                print("이건 선택된 detailCategoryList야 \(data) 💖💖")
            })
            .disposed(by: disposeBag)
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
        let titleLabel = UILabel()
        titleLabel.text = "관심사를 설정해주세요"
        titleLabel.textColor = AppColor.joinText
        titleLabel.textAlignment = .center
        titleLabel.font = notoSansFont.Regular.of(size: 20)
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
    }
    
    @objc func backBarButtonClicked() {
        self.viewModel.input.popDetailInterestsViewTrigger.onNext(())
    }
}
