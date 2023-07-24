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

class CreatePartyViewController: BaseViewController<CreatePartyView> {
    var str = ["zzz","ggg","ddd","FFF","222"]
    
    
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
        configureCell()
        bind()

    }
    
    private func navigationUI() {
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.titleView = rootView.navigationLabel
        self.navigationItem.leftBarButtonItem = rootView.backBarButton
    }
    
    private func bind() {
        rootView.backBarButton.innerButton.rx.tap
            .bind(to: viewModel.input.popVCTrigger)
            .disposed(by: disposeBag)
        
        
        viewModel.output.categories
            .bind(to: rootView.categoryCollectionView.rx.items(cellIdentifier: CategoryImageCollectionViewCell.identifier, cellType: CategoryImageCollectionViewCell.self)) {
                index, category, cell in
                guard let localImage = category.localImgSrc else { return }
                let image = UIImage.loadImageFromDiskWith(fileName: localImage)
                cell.interestsImageView.image = image
                cell.interestsLabel.text = category.name
                cell.configureCell(type: .deselectable, size: .md)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureCell() {
        rootView.categoryCollectionView.register(CategoryImageCollectionViewCell.self, forCellWithReuseIdentifier: CategoryImageCollectionViewCell.identifier)
        rootView.categoryCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        rootView.detailCategoryCollectionView.register(detailCategoryCollectionViewCell.self, forCellWithReuseIdentifier: detailCategoryCollectionViewCell.identifier)
        rootView.detailCategoryCollectionView.dataSource = self
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
//        case rootView.detailCategoryCollectionView:
//            let width: CGFloat = collectionView.frame.width
//            let height: CGFloat = collectionView.frame.height
//            let columns: CGFloat = 4.0
//            let rows: CGFloat = 2.0
//            let horizontalSpacing: CGFloat = 32.0
//            let verticalSpacing: CGFloat = 24.0
//
//            let totalHorizontalSpacing = (columns - 1) * horizontalSpacing
//            let totalVerticalSpacing = (rows - 1) * verticalSpacing
//            let itemWidth = (width - totalHorizontalSpacing) / columns
//            let itemHeight = (height - totalVerticalSpacing) / rows
//            let itemSize = CGSize(width: itemWidth, height: itemHeight)
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

extension CreatePartyViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = rootView.detailCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: detailCategoryCollectionViewCell.identifier, for: indexPath) as? detailCategoryCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(str[indexPath.row])
        return cell
    }
    

}
