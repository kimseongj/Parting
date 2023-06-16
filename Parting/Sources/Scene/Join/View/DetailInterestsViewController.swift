//
//  DetailInterestsViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/06/10.
//

import UIKit
import RxSwift


class Section: Hashable {
    var selectedCategorys: [String]
    var id = UUID()
    
    init(selectedCategorys: [String]) {
        self.selectedCategorys = selectedCategorys
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Section, rhs: Section) -> Bool {
        lhs.id == rhs.id
    }
}

enum SectionTitle: Int, CaseIterable {
    case cultureLife
    case watch
    case selfDevelopement
    case food
    case exercise
    case play
    case cafe
    case drink
}

class DetailInterestsViewController: BaseViewController<DetailInterestsView> {
    static let sectionBackgroundDecorationElementKind = "background"
    private let viewModel: DetailInterestsViewModel
    private let disposeBag = DisposeBag()
    private var categoryTitle: [String] = []
    private var categoryDetailLists: [[String]] = []
    private var cellIdxList: [Int] = []
    

    var dataSource: UICollectionViewDiffableDataSource<SectionTitle, String>?
    
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
        
        dataSource = UICollectionViewDiffableDataSource<SectionTitle, String>(collectionView: self.rootView.detailCategoryCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let section = SectionTitle(rawValue: indexPath.section) else { return UICollectionViewCell() }
            guard let cell = self.rootView.detailCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: detailCategoryCollectionViewCell.identifier, for: indexPath) as? detailCategoryCollectionViewCell else { return nil }
            switch section {
            case .cultureLife:
                cell.configure(itemIdentifier)
                return cell
            case .watch:
                cell.configure(itemIdentifier)
                return cell
            case .cafe:
                cell.configure(itemIdentifier)
                return cell
            case .selfDevelopement:
                cell.configure(itemIdentifier)
                return cell
            case .food:
                cell.configure(itemIdentifier)
                return cell
            case .exercise:
                cell.configure(itemIdentifier)
                return cell
            case .play:
                cell.configure(itemIdentifier)
                return cell
            case .drink:
                cell.configure(itemIdentifier)
                return cell
            }
        })
        
        self.rootView.detailCategoryCollectionView.register(CustomHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomHeaderView.elementKind)
        
        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
            guard let view = self.rootView.detailCategoryCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CustomHeaderView.elementKind, for: indexPath) as? CustomHeaderView else { return UICollectionReusableView() }
        
            view.categoryLabel.text = self.categoryTitle[indexPath.section]
            
            return view
        }
        
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
    
    private func cellResist() {
        self.rootView.detailCategoryCollectionView.register(detailCategoryCollectionViewCell.self, forCellWithReuseIdentifier: detailCategoryCollectionViewCell.identifier)
    }
    
    private func snapShotTest() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionTitle, String>()
        snapshot.appendSections([.cultureLife])
        snapshot.appendItems(categoryDetailLists[0])
        snapshot.appendSections([.cafe])
        snapshot.appendItems(categoryDetailLists[1])
        snapshot.appendSections([.drink])
        snapshot.appendItems(categoryDetailLists[2])
        snapshot.appendSections([.watch])
        snapshot.appendItems(categoryDetailLists[3])
        snapshot.appendSections([.exercise])
        snapshot.appendItems(categoryDetailLists[4])
        snapshot.appendSections([.play])
        snapshot.appendItems(categoryDetailLists[5])
        snapshot.appendSections([.selfDevelopement])
        snapshot.appendItems(categoryDetailLists[6])
        snapshot.appendSections([.food])
        snapshot.appendItems(categoryDetailLists[7])
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
