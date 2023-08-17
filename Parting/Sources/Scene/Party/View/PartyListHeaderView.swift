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
    
//    static let identifier = "PartyListHeaderView"
    
    private let disposeBag = DisposeBag()
    
    var delegate: PartyListHeaderViewDelegate?
    
    var viewModel: PartyListViewModel?
    
    // Prevents multiple setDelegate()
    var didConfiguredCell: Bool
    
    private let mainVStack = StackView(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 0)
    
    private let interestCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        return collectionView
    }()
    
    private let sortingOptionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        return collectionView
    }()
    
    override init(reuseIdentifier: String?) {
        self.didConfiguredCell = false
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
        addSubviews()
        makeConstraints()
        //        configureCollectionViews()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: ProgrammaticallyInitializableViewProtocol
extension PartyListHeaderView: ProgrammaticallyInitializableViewProtocol {
    func setupView() {
        
    }
    
    func addSubviews() {
        addSubview(mainVStack)
        mainVStack.addArrangedSubview(interestCollectionView)
        mainVStack.addArrangedSubview(sortingOptionCollectionView)
    }
    
    func makeConstraints() {
        mainVStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        interestCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        sortingOptionCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
    }
    
    
    
}

// MARK: CollectionView Congiruation
extension PartyListHeaderView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    private func setCollectionViewDelegate() {
        sortingOptionCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        interestCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func configureCollectionViews() {
        
        // Register Cell
        sortingOptionCollectionView.register(SortingOptionCollectionViewCell.self, forCellWithReuseIdentifier: SortingOptionCollectionViewCell.identifier)
        interestCollectionView.register(InterestBarCollectionViewCell.self, forCellWithReuseIdentifier: InterestBarCollectionViewCell.identifier)
        
        setCollectionViewDelegate()
        
        
        guard let viewModel = viewModel else { return }
        
        
        
        // BINDING: interestCollectionView - Two Way Binding
        viewModel.output.associatedCategoriesToRequest
            .bind(to: self.interestCollectionView.rx.items(cellIdentifier: InterestBarCollectionViewCell.identifier, cellType: InterestBarCollectionViewCell.self)) { [weak self] index, item, cell in
                let categoryDetail = item.0
                let isSelected = item.1
                cell.configureCell(with: categoryDetail)
                cell.setCellSelected(to: isSelected)
                
                // Update layout for textLabel to grow dynamically
                DispatchQueue.main.async {
                    self?.interestCollectionView.collectionViewLayout.invalidateLayout()
                }
            }
            .disposed(by: disposeBag)
        
        interestCollectionView.rx
            .itemSelected
            .bind(to: viewModel.input.updateAssociatedCategoriesTrigger)
            .disposed(by: disposeBag)

        
        
        // BINDING: sortingOptionCollectionView
        viewModel.output.sortingOptions.bind(to: self.sortingOptionCollectionView.rx.items(cellIdentifier: SortingOptionCollectionViewCell.identifier, cellType: SortingOptionCollectionViewCell.self)) { [weak self] index, text, cell in
            cell.textLabel.text = text
            
            if index == 2 {
                cell.icon.image = UIImage(systemName: Images.sfSymbol.map)
            } else {
                cell.icon.image = UIImage(systemName: Images.sfSymbol.downChevron)
            }
            DispatchQueue.main.async {
                self?.sortingOptionCollectionView.collectionViewLayout.invalidateLayout()
            }
        }.disposed(by: disposeBag)
        
        
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
        
        if collectionView == sortingOptionCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as? SortingOptionCollectionViewCell
            let text = cell?.textLabel.text ?? "거리 순 O "
            let width = text.size(withAttributes: [
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)
            ]).width + 48
            return CGSize(width: width, height: self.frame.height / 2)
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as? InterestBarCollectionViewCell
            
            let text = cell?.textLabel.text ?? "스터디"
            let width = text.size(withAttributes: [
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)
            ]).width + 24
            return CGSize(width: width, height: self.frame.height / 2)
            
        }
        
    } /* End sizeForItemAt */
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}


//class PartyListHeaderView: UITableViewHeaderFooterView {
//
////	static let identifier = "PartyListHeaderView"
//
//	private let disposeBag = DisposeBag()
//
//	private let mainVStack = StackView(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 0)
//
//	private let interestCollectionView: UICollectionView = {
//		let layout = UICollectionViewFlowLayout()
//		layout.scrollDirection = .horizontal
//		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//		return collectionView
//	}()
//
//	private let sortingOptionCollectionView: UICollectionView = {
//		let layout = UICollectionViewFlowLayout()
//		layout.scrollDirection = .horizontal
//		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//		return collectionView
//	}()
//
//	override init(reuseIdentifier: String?) {
//		super.init(reuseIdentifier: reuseIdentifier)
//		setupView()
//		addSubviews()
//		makeConstraints()
//		configureCollectionViews()
//	}
//
//	required init?(coder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
//
//}
//
//// MARK: ProgrammaticallyInitializableViewProtocol
//extension PartyListHeaderView: ProgrammaticallyInitializableViewProtocol {
//	func setupView() {
//		mainVStack.backgroundColor = .systemTeal
//	}
//
//	func addSubviews() {
//		addSubview(mainVStack)
//		mainVStack.addArrangedSubview(interestCollectionView)
//		mainVStack.addArrangedSubview(sortingOptionCollectionView)
//	}
//
//	func makeConstraints() {
//		mainVStack.snp.makeConstraints { make in
//			make.edges.equalToSuperview()
//		}
//
//		interestCollectionView.snp.makeConstraints { make in
//			make.horizontalEdges.equalToSuperview()
//			make.height.equalToSuperview().multipliedBy(0.5)
//		}
//
//		sortingOptionCollectionView.snp.makeConstraints { make in
//			make.horizontalEdges.equalToSuperview()
//			make.height.equalToSuperview().multipliedBy(0.5)
//		}
//
//	}
//
//
//
//}
//
//// MARK: CollectionView Delagate, DataSource
//extension PartyListHeaderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//	private func configureCollectionViews() {
//		sortingOptionCollectionView.delegate = self
//		sortingOptionCollectionView.dataSource = self
//		sortingOptionCollectionView.register(SortingOptionCollectionViewCell.self, forCellWithReuseIdentifier: SortingOptionCollectionViewCell.identifier)
//		interestCollectionView.delegate = self
//		interestCollectionView.dataSource = self
//		interestCollectionView.register(InterestBarCollectionViewCell.self, forCellWithReuseIdentifier: InterestBarCollectionViewCell.identifier)
//
//		interestCollectionView.rx.itemSelected
//            .withUnretained(self)
//			.subscribe(onNext: { owner, indexPath in
//
//				guard let cell = owner.interestCollectionView.cellForItem(at: indexPath) as? InterestBarCollectionViewCell else { return }
//
//				cell.cellTapped()
//
//			})
//			.disposed(by: disposeBag)
//
//		interestCollectionView.showsHorizontalScrollIndicator = false
//		sortingOptionCollectionView.showsHorizontalScrollIndicator = false
//		interestCollectionView.decelerationRate = .fast
//		sortingOptionCollectionView.decelerationRate = .fast
//
//	}
//
//	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//		return 3
//	}
//
//	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//		if collectionView == sortingOptionCollectionView {
//			guard let cell = sortingOptionCollectionView.dequeueReusableCell(withReuseIdentifier: SortingOptionCollectionViewCell.identifier, for: indexPath) as? SortingOptionCollectionViewCell else { return UICollectionViewCell() }
//
//			return cell
//		} else {
//			guard let cell = interestCollectionView.dequeueReusableCell(withReuseIdentifier: InterestBarCollectionViewCell.identifier, for: indexPath) as? InterestBarCollectionViewCell else { return UICollectionViewCell() }
//
//			return cell
//		}
//
//
//	}
//
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//		if collectionView == sortingOptionCollectionView {
//
//			let text = "거리 순 O"
//			let width = text.size(withAttributes: [
//				NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)
//			]).width + 20
//			return CGSize(width: width, height: self.frame.height / 2)
//		} else {
//			let text = "스터디"
//			let width = text.size(withAttributes: [
//				NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)
//			]).width + 24
//			return CGSize(width: width, height: self.frame.height / 2)
//
//		}
//
//	} /* End sizeForItemAt */
//
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//		return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
//	}
//}
