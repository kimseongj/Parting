//
//  CreatePartyViewController.swift
//  Parting
//
//  Created by 김민규 on 2023/07/17.
//

import Foundation
import UIKit
import RxSwift

class CreatePartyViewController: BaseViewController<CreatePartyView> {
	
	private var viewModel: CreatePartyViewModel
	
	private let disposeBag = DisposeBag()
	
	init(viewModel: CreatePartyViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationUI()
		bindViewModel()
		configureCell()
	}
	
	
	private func navigationUI() {
		navigationController?.isNavigationBarHidden = false
		self.navigationItem.titleView = rootView.navigationLabel
		self.navigationItem.leftBarButtonItem = rootView.backBarButton
		
	}
	
	private func configureCell() {
		rootView.categoryCollectionView.register(CategoryImageCollectionViewCell.self, forCellWithReuseIdentifier: CategoryImageCollectionViewCell.identifier)
		
//		rootView.categoryCollectionView.rx.setDelegate(self)
//			.disposed(by: disposeBag)
//
//		rootView.categoryCollectionView.rx.itemSelected
//			.subscribe { [weak self] indexPath in
//				self?.viewModel.pushPartyListVC(title: InterestsCategory(rawValue: indexPath[1])?.category ?? "Error")
//			}
//			.disposed(by: disposeBag)
		
		
	}
	
	
	private func bindViewModel() {
		rootView.backBarButton.innerButton
			.rx.tap.bind(to: viewModel.input.popVCTrigger)
			.disposed(by: disposeBag)
		
//		viewModel.output.categoryImages
//			.bind(to: rootView.categoryCollectionView.rx.items(cellIdentifier: CategoryImageCollectionViewCell.identifier, cellType: CategoryImageCollectionViewCell.self)) { index, imgSrc, cell in
//
//				cell.interestsImageView.kf.setImage(with: URL(string: imgSrc))
//
//				if let text = InterestsCategory(rawValue: index)?.category {
//					cell.interestsLabel.text = text + "팟"
//				}
//				cell.configureCell(type: .normal, size: .md)
//			}.disposed(by: disposeBag)
	}
	
}

extension CreatePartyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return UICollectionViewCell()
	}
	
	
	
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





