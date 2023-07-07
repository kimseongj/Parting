//
//  HomeViewController.swift
//  Parting
//
//  Created by 김민규 on 2023/05/09.
//

import Foundation
import UIKit
import RxSwift
import Kingfisher

class HomeViewController: BaseViewController<HomeView> {
	
	private var viewModel: HomeViewModel
	
	private let disposeBag = DisposeBag()

	init(viewModel: HomeViewModel) {
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
		self.navigationItem.rightBarButtonItem = rootView.bellBarButton
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: rootView.navigationLabel)

	}
	
	private func configureCell() {
		rootView.categoryCollectionView.register(CategoryImageCollectionViewCell.self, forCellWithReuseIdentifier: CategoryImageCollectionViewCell.identifier)
		rootView.categoryCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
		
	}
	
	private func bindViewModel() {
		rootView.calendarWidget.rx.tap
			.bind(to: viewModel.input.pushScheduleVCTrigger)
			.disposed(by: disposeBag)
		
		viewModel.output.categoryImages
			.bind(to: rootView.categoryCollectionView.rx.items(cellIdentifier: CategoryImageCollectionViewCell.identifier, cellType: CategoryImageCollectionViewCell.self)) { index, imgSrc, cell in
				
				cell.interestsImageView.kf.setImage(with: URL(string: imgSrc))
				if let text = InterestsCategory(rawValue: index)?.category {
					
					cell.interestsLabel.text = text + "팟"
				}
				cell.configureCell(type: .normal)
			}.disposed(by: disposeBag)
	}
	
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {

	
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
