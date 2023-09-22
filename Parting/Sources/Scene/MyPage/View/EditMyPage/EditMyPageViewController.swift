//
//  EditMyPageViewController.swift
//  Parting
//
//  Created by 이병현 on 2023/09/22.
//

import UIKit
import RxCocoa

final class EditMyPageViewController: BaseViewController<EditMyPageView> {
    
    private var viewModel: EditMyPageViewModel
    
    init(viewModel: EditMyPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var interestDataSource: UICollectionViewDiffableDataSource<Int, UIImage>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        bind()
        setMyInterestDataSource()
        var snapshot = NSDiffableDataSourceSnapshot<Int, UIImage>()
        snapshot.appendSections([0])
        var arr: [UIImage] = [UIImage(named: "관람")!, UIImage(named: "문화생활")!, UIImage(named: "술")!]
        snapshot.appendItems(arr)
        self.interestDataSource.apply(snapshot)
    }
}

extension EditMyPageViewController {
    private func bind() {
        rootView.backBarButton.innerButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.viewModel.popVC()
            }
            .disposed(by: disposeBag)
    }
}

extension EditMyPageViewController {
    private func navigationUI() {
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = rootView.backBarButton
        self.navigationItem.titleView = rootView.navigationLabel
    }
}

extension EditMyPageViewController {
    private func setMyInterestDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<InterestCollectionViewCell, UIImage> { cell, indexPath, itemIdentifier in
            cell.imageView.image = itemIdentifier
        }
        
        interestDataSource = UICollectionViewDiffableDataSource(collectionView: rootView.myInterestCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
    }
}
