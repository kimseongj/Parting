//
//  PartyListHeaderView.swift
//  Parting
//
//  Created by 김민규 on 2023/07/15.
//

import UIKit
import RxSwift
import RxDataSources

protocol PartyListHeaderViewDelegate {
    func didTapSortingOptionCell(_ orderOption: SortingOption)
}

class PartyListHeaderView: UITableViewHeaderFooterView {
    
    private let disposeBag = DisposeBag()
    
    var delegate: PartyListHeaderViewDelegate?
    
    var viewModel: PartyListViewModel?
    
    var didConfiguredCell: Bool
    
    private let mainVStack = StackView(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 15)
    
    private let sortingOptionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
//        collectionView.backgroundColor = AppColor.brand
        return collectionView
    }()
    
    override init(reuseIdentifier: String?) {
        self.didConfiguredCell = false
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
        addSubviews()
        makeConstraints()
        configureCollectionViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: ProgrammaticallyInitializableViewProtocol
extension PartyListHeaderView: ProgrammaticallyInitializableViewProtocol {
    func addSubviews() {
        addSubview(sortingOptionCollectionView)
    }
    
    func makeConstraints() {
        sortingOptionCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: CollectionView Congiruation
extension PartyListHeaderView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    private func setCollectionViewDelegate() {
        sortingOptionCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func configureCollectionViews() {
        
        // Register Cell
        sortingOptionCollectionView.register(SortingOptionCollectionViewCell.self, forCellWithReuseIdentifier: SortingOptionCollectionViewCell.identifier)
        setCollectionViewDelegate()
        
        
        guard let viewModel = viewModel else {
            print("viewModel 생성안됨")
            return
        }
        
        sortingOptionCollectionView.rx.itemSelected
            .withUnretained(self)
            .subscribe(onNext: { owner, indexPath in
                var orderOption: SortingOption
                
                if indexPath[1] == 0 {
                    orderOption = .numberOfPeople(.none)
                } else {
                    orderOption = .time(.none)
                }
                
                if indexPath[1] < 2 {
                    owner.delegate?.didTapSortingOptionCell(orderOption)
                    
                }
            })
            .disposed(by: disposeBag)
        
        
        
        didConfiguredCell = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let cell = collectionView.cellForItem(at: indexPath) as? SortingOptionCollectionViewCell
            let text = cell?.textLabel.text ?? "거리 순 O "
            let width = text.size(withAttributes: [
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)
            ]).width + 48
            return CGSize(width: width, height: self.frame.height / 2)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

