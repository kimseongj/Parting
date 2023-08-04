//
//  CreatePartyViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/07/22.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import Toast

class CreatePartyViewController: BaseViewController<CreatePartyView> {
    var currentSelectedIndex: Int?
    var selectedDetailCategoryLists = Set<Int>()
   
    private var viewModel: CreatePartyViewModel
    init(viewModel: CreatePartyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    deinit {
        print("CreatePartyVC 메모리해제")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        registerCell()
        bind()

    }
    
    private func navigationUI() {
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.titleView = rootView.navigationLabel
        self.navigationItem.leftBarButtonItem = rootView.backBarButton
    }
    
    private func bind() {
        
        rootView.setLocationButton.rx.tap
            .bind(to: viewModel.input.setMapVCTrigger)
            .disposed(by: disposeBag)
        
        rootView.backBarButton.innerButton.rx.tap
            .bind(to: viewModel.input.popVCTrigger)
            .disposed(by: disposeBag)
        
        // MARK: - cellForItemAt(DataSource)
        viewModel.output.categories
            .bind(to: rootView.categoryCollectionView.rx.items(cellIdentifier: CategoryImageCollectionViewCell.identifier, cellType: CategoryImageCollectionViewCell.self)) { [weak self]
                row, category, cell in
                guard let localImage = category.localImgSrc else { return }
                let image = UIImage.loadImageFromDiskWith(fileName: localImage)
                cell.interestsImageView.image = image
                cell.interestsLabel.text = category.name
                
                // selectedIndex가 cell의 index와 같으면 해당 셀 configure(.normal)
                if self?.viewModel.selectedIndex == row {
                    cell.configureCell(type: .normal, size: .md)
                } // selectedIndex가 cell의 index와 다르면 configure(.deselectable)
                else {
                    cell.configureCell(type: .deselectable, size: .md)
                }
            }
            .disposed(by: disposeBag)

        // MARK: - cellForItemAt(DataSource)
        // MARK: - 2. categoryDetailLists에 detailCategoryCollectionView 바인드 => cell에 데이터를 그려주는 작업
        viewModel.output.categoryDetailLists
            .bind(to: rootView.detailCategoryCollectionView.rx
                .items(cellIdentifier: detailCategoryCollectionViewCell.identifier, cellType: detailCategoryCollectionViewCell.self)) { [weak self] row, element, cell in
                cell.configure(self?.viewModel.categoryDetailListsData?[row].categoryDetailName ?? "")
//                    print(self?.selectedDetailCategoryLists)
                    guard let flag = self?.selectedDetailCategoryLists.contains(row) else { return }
                    if flag {
                        cell.backGroundView.backgroundColor = AppColor.brand
                    } else {
                        cell.backGroundView.backgroundColor = AppColor.gray400
                    }
            }
            .disposed(by: disposeBag)
        
    
        Observable
            .zip(rootView.categoryCollectionView.rx.modelSelected(CategoryModel.self), rootView.categoryCollectionView.rx.itemSelected)
            .subscribe(onNext: { [weak self] (item, indexPath) in
                self?.viewModel.isSeletedCellIdx.onNext(indexPath.item)
                print(indexPath.item)
                self?.viewModel.input.partyCellClickedState.onNext(item.id)
                self?.viewModel.selectedIndex = indexPath.item
                self?.rootView.categoryCollectionView.reloadData()
                
                self?.viewModel.selectedDetailCategoryCell.accept([])
                self?.rootView.detailCategoryCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.output.categoryDetailLists
            .withUnretained(self)
            .subscribe(onNext: { owner, detaillists in
                owner.rootView.detailCategoryCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        rootView.detailCategoryCollectionView.rx
            .itemSelected
            .subscribe(onNext: {[weak self] indexPath in
                self?.viewModel.input.detailCategoryCellSelectedIndexPath.onNext(indexPath.item)
        })
        .disposed(by: disposeBag)
        
        
        viewModel.toastMessage
            .observe(on: MainScheduler.instance)
            .bind { [weak self] toastMessage in
                self?.view.makeToast(toastMessage)
            }
            .disposed(by: disposeBag)
        
        viewModel.selectedDetailCategoryCell
            .bind { [weak self] indexList in
                print(indexList)
                self?.selectedDetailCategoryLists = indexList
                self?.rootView.detailCategoryCollectionView.reloadData()
            }
            .disposed(by: disposeBag)

    }
    
    private func registerCell() {
        rootView.categoryCollectionView.register(CategoryImageCollectionViewCell.self, forCellWithReuseIdentifier: CategoryImageCollectionViewCell.identifier)
        rootView.categoryCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        rootView.detailCategoryCollectionView.register(detailCategoryCollectionViewCell.self, forCellWithReuseIdentifier: detailCategoryCollectionViewCell.identifier)

        rootView.detailCategoryCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
   
}

extension CreatePartyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case rootView.categoryCollectionView:
            let width: CGFloat = collectionView.frame.width
            let height: CGFloat = collectionView.frame.height
            let columns: CGFloat = 4.0
            let rows: CGFloat = 2.0
            let horizontalSpacing: CGFloat = 32.0
            let verticalSpacing: CGFloat = 24.0
            
            let totalHorizontalSpacing = (columns - 1) * horizontalSpacing
            let totalVerticalSpacing = (rows - 1) * verticalSpacing
            let itemWidth = (width - totalHorizontalSpacing) / columns
            let itemHeight = (height - totalVerticalSpacing) / rows
            let itemSize = CGSize(width: itemWidth, height: itemHeight)
            
            return itemSize
        default:
            break
        }
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24.0 // height
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 32.0 // horizontal spacing

    }
}

extension CreatePartyViewController {
    func dataFetchingDetailCategoryCellIndex(_ indexList: [Int]) {
        
    }
}

//extension CreatePartyViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.categoryDetailListsData?.count ?? 0
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = rootView.detailCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: detailCategoryCollectionViewCell.identifier, for: indexPath) as? detailCategoryCollectionViewCell else { return UICollectionViewCell() }
//        cell.configure(viewModel.categoryDetailListsData?[indexPath.item].categoryDetailName ?? "")
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
//
//
//}

