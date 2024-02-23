//
//  PartyListViewController.swift
//  Parting
//
//  Created by 김민규 on 2023/07/11.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class PartyListViewController: BaseViewController<PartyListView> {
    private var viewModel: PartyListViewModel
    
    private var isPaging: Bool = false
    
    init(viewModel: PartyListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.input.viewWillAppear.onNext(())
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
        self.viewModel.input.viewDidLoad.onNext(())
        rootView.noPartyListView.isHidden = true
    }
    
    
    private func navigationUI() {
        navigationController?.isNavigationBarHidden = false
    }
    
    private func configureTableView() {
        rootView.partyListTableView.rx.setDelegate(self).disposed(by: disposeBag)
        rootView.partyListTableView.register(PartyTableViewCell.self, forCellReuseIdentifier: PartyTableViewCell.identifier)
    }
    
    private func bindViewModel() {
        rootView.addButton
            .rx.tap.bind(to: viewModel.input.pushCreatePartyVCTrigger)
            .disposed(by: disposeBag)
        
        viewModel.output.hasParty
            .withUnretained(self)
            .bind(onNext: { owner, hasParty in
                if hasParty {
                    owner.rootView.showPartyListTableView()
                } else {
                    owner.rootView.hidePartyListTableView()
                }
            }).disposed(by: disposeBag)
        
        viewModel.output.partyList.bind(to: rootView.partyListTableView.rx.items(cellIdentifier: PartyTableViewCell.identifier, cellType: PartyTableViewCell.self)) { index, party, cell in
            cell.selectionStyle = .none
            cell.fill(with: party)
        }.disposed(by: disposeBag)
             
        viewModel.input.currentSortingOptionRelay
            .withUnretained(self)
            .bind(onNext: { owner, sortingOption in
            owner.rootView.buttonTitleLabel.text = sortingOption.description

        }).disposed(by: disposeBag)
        
        rootView.partyListTableView.rx
            .modelSelected(PartyListItemModel.self)
            .withUnretained(self)
            .subscribe(onNext: { owner, cellModel in
                owner.viewModel.input.didSelectCell.onNext(cellModel.id)
                print(cellModel.id, "🥰")
            })
            .disposed(by: disposeBag)
        
        rootView.sortingOptionButton
            .rx.tap.withUnretained(self).bind(onNext: { owner, _ in
                let partySortingModalViewController = PartySortingModalViewController(viewModel: owner.viewModel)
                partySortingModalViewController.modalPresentationStyle = .overFullScreen
                owner.present(partySortingModalViewController, animated: false)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Table View
extension PartyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 166
    }
}

extension PartyListViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        if offsetY > (contentHeight - height) && !isPaging && viewModel.output.hasNextPage {
            rootView.activityIndicator.startAnimating()
            beginPaging()
        } 
    }
    
    func beginPaging() {
        isPaging = true
        pagepartyListTableView()
    }
    
    func pagepartyListTableView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            
            viewModel.pagePartyList()
            self.rootView.activityIndicator.stopAnimating()
            self.isPaging = false
        }
    }
}
