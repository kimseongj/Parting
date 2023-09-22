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
        rootView.detailCategoryCollectionView.allowsMultipleSelection = true
    }
    
    private func setDataSource() {
        rootView.detailCategoryCollectionView.rx.setDataSource(self)
            .disposed(by: disposeBag)
        
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
                print(owner.categoryDetailLists)
            })
            .disposed(by: disposeBag)
		
		rootView.serviceStartButton.rx.tap
			.bind(to: viewModel.input.naviagteToPublicScreenTrigger)
			.disposed(by: disposeBag)
    }
    
    private func headerViewResist() {
        self.rootView.detailCategoryCollectionView.register(CustomHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomHeaderView.elementKind)
    }
    
    private func cellResist() {
        self.rootView.detailCategoryCollectionView.register(detailCategoryCollectionViewCell.self, forCellWithReuseIdentifier: detailCategoryCollectionViewCell.identifier)
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



extension DetailInterestsViewController: UICollectionViewDataSource, ButtonColorChange {
    func changeButtonColor(state: Bool) {
        rootView.changeCompleteButtonColor(state: state)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categoryTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryDetailLists[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCategoryCollectionViewCell.identifier, for: indexPath) as? detailCategoryCollectionViewCell else { return UICollectionViewCell() }
        cell.categoryNameLabel.text = categoryDetailLists[indexPath.section][indexPath.item]
        cell.delegate = self
                
        return cell
    }
}
