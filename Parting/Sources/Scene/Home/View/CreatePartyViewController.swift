//
//  CreatePartyViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/07/22.
//

import UIKit
import RxSwift
import RxCocoa

class CreatePartyViewController: BaseViewController<CreatePartyView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        configureCell()
    }
    
    private func navigationUI() {
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: rootView.navigationLabel)
    }
    
    private func configureCell() {
        rootView.categoryCollectionView.register(CategoryImageCollectionViewCell.self, forCellWithReuseIdentifier: CategoryImageCollectionViewCell.identifier)
        rootView.categoryCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
   
}

extension CreatePartyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24.0 // height
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 32.0 // horizontal spacing

    }
}

