//
//  DetailInterestsListView.swift
//  Parting
//
//  Created by kimseongjun on 1/16/24.
//

import UIKit

enum Section {
    case main
}

final class DetailInterestsListView: BaseView {
    private var categoryDetailDataSource: UICollectionViewDiffableDataSource<Section, CategoryDetail>?
    
    private let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        return label
    }()
    
    lazy var detailCategoryCollectionView: MutableSizeCollectionView = {
        let leftAlignedCollectionViewFlowLayout = LeftAlignedCollectionViewFlowLayout()
        leftAlignedCollectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
        let collectionView = MutableSizeCollectionView(frame: .zero, collectionViewLayout: leftAlignedCollectionViewFlowLayout)
        collectionView.layer.cornerRadius = 8
        collectionView.layer.backgroundColor = UIColor(red: 0.973, green: 0.98, blue: 0.992, alpha: 1).cgColor
        collectionView.allowsMultipleSelection = true
        collectionView.register(DetailCategoryCollectionViewCell.self, forCellWithReuseIdentifier: DetailCategoryCollectionViewCell.identifier)
        return collectionView
    }()
    
    func fill(text: String, categoryDetailList: [CategoryDetail]) {
        categoryTitleLabel.text = text
        applySnapshot(categoryDetailList: categoryDetailList)
    }
    
    func configureDetailCategoryCollectionView() {
        if let flowLayout = detailCategoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    override func makeConfigures() {
        super.makeConfigures()
        [categoryTitleLabel, detailCategoryCollectionView].forEach {
            self.addSubview($0)
        }
    }
    
    override func makeConstraints() {
        categoryTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(24)
        }
        
        detailCategoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryTitleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(24)
        }
    }
}

extension DetailInterestsListView {
    func configureCategoryDetailDataSource() {
        categoryDetailDataSource = UICollectionViewDiffableDataSource<Section, CategoryDetail> (collectionView: detailCategoryCollectionView) { (collectionView, indexPath, categoryDetail) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCategoryCollectionViewCell.identifier, for: indexPath) as? DetailCategoryCollectionViewCell else { return nil }
            
            cell.fill(with: categoryDetail.categoryDetailName)
            
            return cell
        }
    }
    
    func applySnapshot(categoryDetailList: [CategoryDetail]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CategoryDetail>()
        snapshot.appendSections([.main])
        snapshot.appendItems(categoryDetailList)
        self.categoryDetailDataSource?.apply(snapshot, animatingDifferences: true)
    }
}
