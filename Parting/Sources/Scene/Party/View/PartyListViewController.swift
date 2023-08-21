//
//  PartyListViewController.swift
//  Parting
//
//  Created by 김민규 on 2023/07/11.
//

import Foundation
import UIKit
import RxSwift
import Kingfisher

class PartyListViewController: BaseViewController<PartyListView> {
    
    private var viewModel: PartyListViewModel
    
    private var tableViewReachedEndCount = 0
    
    private let spinner = UIActivityIndicatorView(style: .large)
    
    init(viewModel: PartyListViewModel, title: String) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.rootView.navigationLabel.text = title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.loadPartyList()
        rootView.partyListTableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("PartyListVC 메모리 해제")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        bindViewModel()
        configureTableView()
        self.viewModel.loadPartyList()
    }
    
    
    private func navigationUI() {
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.rightBarButtonItem = rootView.bellBarButton
        self.navigationItem.leftBarButtonItem = rootView.backBarButton
        self.navigationItem.titleView = rootView.navigationLabel
        
    }
    
    private func configureTableView() {
        rootView.partyListTableView.sectionHeaderTopPadding = 8
        rootView.partyListTableView.rx.setDelegate(self).disposed(by: disposeBag)
        rootView.partyListTableView.register(PartyTableViewCell.self, forCellReuseIdentifier: PartyTableViewCell.identifier)
        rootView.partyListTableView.register(PartyListHeaderView.self, forHeaderFooterViewReuseIdentifier: PartyListHeaderView.identifier)
    }
    
    private func bindViewModel() {
        rootView.backBarButton.innerButton
            .rx.tap.bind(to: viewModel.input.popVCTrigger)
            .disposed(by: disposeBag)
        rootView.fab
            .rx.tap.bind(to: viewModel.input.pushCreatePartyVCTrigger)
            .disposed(by: disposeBag)
        
        viewModel.output.partyList.bind(to: rootView.partyListTableView.rx.items(cellIdentifier: PartyTableViewCell.identifier, cellType: PartyTableViewCell.self)) { [weak self] index, party, cell in
            print(party, "파티데이터 💢")
            cell.selectionStyle = .none
            cell.configureCell(party: party)
        }.disposed(by: disposeBag)
        
        viewModel.output.isLoadingMore
            .withUnretained(self)
            .subscribe(onNext: { owner, isLoading in

            if isLoading {
                owner.spinner.startAnimating()
                owner.rootView.partyListTableView.tableFooterView?.isHidden = false
            } else {
                owner.spinner.stopAnimating()
                owner.rootView.partyListTableView.tableFooterView?.isHidden = true
                
                
                let cellHeight = owner.rootView.window?.windowScene?.screen.bounds.height ?? 852
                
                let boundsHeight = owner.rootView.partyListTableView.bounds.height
                let cellCountInTableView = Int(ceil(boundsHeight / cellHeight))
                if owner.viewModel.output.partyList.value.count > cellCountInTableView {
                    let contentHeight = owner.rootView.partyListTableView.contentSize.height
                    
                    let bottomOffset = CGPoint(x: 0, y: contentHeight - boundsHeight - 40)
                    owner.rootView.partyListTableView.setContentOffset(bottomOffset, animated: true)
                }
            }
        }).disposed(by: disposeBag)
        
    }
    
}

// MARK: Table View
extension PartyListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = rootView.window?.windowScene?.screen.bounds.height
        return (height ?? 852.0) * 0.25
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: PartyListHeaderView.identifier) as? PartyListHeaderView else { return PartyListHeaderView() }
        header.viewModel = self.viewModel
        header.delegate = self
        if !header.didConfiguredCell {
            header.configureCollectionViews()
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height = rootView.window?.windowScene?.screen.bounds.height
        return (height ?? 852.0) * 0.1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            
            
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            self.rootView.partyListTableView.tableFooterView = spinner
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
//        let didReachedEnd = rootView.partyListTableView.contentOffset.y > (rootView.partyListTableView.contentSize.height - rootView.partyListTableView.bounds.size.height + 60)
//        tableViewReachedEndCount += 1
//
//        if didReachedEnd && tableViewReachedEndCount > 2 {
//            self.viewModel.loadPartyListMore()
//        }
    }
    
}

// MARK: PartyListHeaderViewDelegate
extension PartyListViewController: PartyListHeaderViewDelegate {
    func didTapSortingOptionCell(_ orderOption: SortingOption) {
        let vc = SortingOptionModalViewController(viewModel: viewModel, for: orderOption)
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        
        present(vc, animated: true, completion: nil)
        
    }
    
    
}

//class PartyListViewController: BaseViewController<PartyListView> {
//
//	private var viewModel: PartyListViewModel
//
//	init(viewModel: PartyListViewModel, title: String) {
//		self.viewModel = viewModel
//		super.init(nibName: nil, bundle: nil)
//		self.rootView.navigationLabel.text = title + "팟"
//	}
//
//	required init?(coder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
//
//    deinit {
//        print("PartyListVC 메모리해제")
//
//    }
//
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		navigationUI()
//		bindViewModel()
//		configureTableView()
//        checkMyPartytestAPI()
//	}
//
//    private func checkMyPartytestAPI() {
//        print("🌟🌟🌟MYParty TEST 입니다🌟🌟🌟")
//        APIManager.shared.checkMyParty(
//            pageNumber: 0,
//            lat: 35.88979460661547,
//            lng: 128.61133694145016) { data in
//                print(data, "checkMyPage TEST 입니다🔥🔥")
//            }
//    }
//
//	private func navigationUI() {
//		navigationController?.isNavigationBarHidden = false
//		self.navigationItem.rightBarButtonItem = rootView.bellBarButton
//		self.navigationItem.leftBarButtonItem = rootView.backBarButton
//		self.navigationItem.titleView = rootView.navigationLabel
//	}
//
//	private func configureTableView() {
//		rootView.partyListTableView.rx.setDelegate(self).disposed(by: disposeBag)
//		rootView.partyListTableView.register(PartyTableViewCell.self, forCellReuseIdentifier: PartyTableViewCell.identifier)
//		rootView.partyListTableView.register(PartyListHeaderView.self, forHeaderFooterViewReuseIdentifier: PartyListHeaderView.identifier)
//	}
//
//	private func bindViewModel() {
//		rootView.backBarButton.innerButton
//			.rx.tap.bind(to: viewModel.input.popVCTrigger)
//			.disposed(by: disposeBag)
//		rootView.fab
//			.rx.tap.bind(to: viewModel.input.pushCreatePartyVCTrigger)
//			.disposed(by: disposeBag)
//
//		viewModel.output.partyList.bind(to: rootView.partyListTableView.rx.items(cellIdentifier: PartyTableViewCell.identifier, cellType: PartyTableViewCell.self)) { index, party, cell in
//			cell.selectionStyle = .none
//			cell.configureCell(party: party)
//        }.disposed(by: disposeBag)
//	}
//}
//
//extension PartyListViewController: UITableViewDelegate {
//
//	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//		let height = rootView.window?.windowScene?.screen.bounds.height
//		return (height ?? 852.0) * 0.25
//	}
//
//	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//		guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: PartyListHeaderView.identifier) as? PartyListHeaderView else { return UITableViewHeaderFooterView() }
//		return header
//	}
//
//	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//		let height = rootView.window?.windowScene?.screen.bounds.height
//		return (height ?? 852.0) * 0.1
//	}
//
//}

