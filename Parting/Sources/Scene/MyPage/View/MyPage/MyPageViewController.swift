//
//  MyPageViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/07/13.
//

import UIKit
import RxSwift
import RxCocoa

enum TableViewList {
    case aboutParty
    case setParty
    case etcParty

    var title: [String] {
        switch self {
        case .aboutParty:
            return ["최근 본 파티", "내가 개설한 파티", "내가 참여한 파티"]
        case .setParty:
            return ["다크모드", "도움말", "알림 설정", "로그아웃"]
        case .etcParty:
            return ["신고하기", "이용 약관", "문의하기"]
        }
    }
    
    var image: [String] {
        switch self {
        case .aboutParty:
            return ["recentlyParty", "myParty", "participate"]
        case .setParty:
            return ["darkMode", "'help", "bell", "logout"]
        case .etcParty:
            return ["report", "", "mail"]
        }
    }
}

struct MyPageModel: Hashable {
    let image: UIImage
    let title: String
}


final class MyPageViewController: BaseViewController<MyPageView> {
    
    private var viewModel: MyPageViewModel
    
    init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, MyPageModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        viewModel.input.viewDidLoadTrigger.accept(())
        bind()
        setDataSource()
        setDelegate()
        setDataSourceAndDelegate()
        cellRegister()
        setTableViewHeight()
        var snapshot = NSDiffableDataSourceSnapshot<Int, MyPageModel>()
        snapshot.appendSections([0])
        var arr: [MyPageModel] = [MyPageModel(image: UIImage(named: "currentParty")!, title: MyPageCellTitle.current.rawValue), MyPageModel(image: UIImage(named: "createParty")!, title: MyPageCellTitle.create.rawValue), MyPageModel(image: UIImage(named: "participateParty")!, title: MyPageCellTitle.participate.rawValue)]
        snapshot.appendItems(arr)
        self.dataSource.apply(snapshot)
    }
    
    private func setDelegate() {
        rootView.categoryCollectionView.delegate = self
    }
    
    private func setTableViewHeight() {
        rootView.setTableViewRowHeight(rootView.aboutPartyTableView)
        rootView.setTableViewRowHeight(rootView.setPartyTableView)
        rootView.setTableViewRowHeight(rootView.setETCTableView)
    }
    
    private func cellRegister() {
        rootView.aboutPartyTableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.identifier)
        rootView.setPartyTableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.identifier)
        rootView.setETCTableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.identifier)
    }
    
    private func setDataSourceAndDelegate() {
        tableViewDataSourceAndDelegate(rootView.aboutPartyTableView)
        tableViewDataSourceAndDelegate(rootView.setPartyTableView)
        tableViewDataSourceAndDelegate(rootView.setETCTableView)
    }
    
    private func tableViewDataSourceAndDelegate(_ tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func navigationUI() {
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: rootView.navigationLabel)
    }
    
    private func bind() {
        rootView.settingUnfoldButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.viewModel.setUnfoldButton(state: true)
                owner.rootView.setPartyTableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.settingUnfoldButtonState
            .withUnretained(self)
            .subscribe(onNext: { owner, state in
                owner.rootView.setTableViewUIUpdate(state: state)
            })
            .disposed(by: disposeBag)
        
        rootView.etcUnfoldButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.viewModel.etcUnfoldButton(state: true)
                owner.rootView.setETCTableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.etcUnfoldButtonState
            .withUnretained(self)
            .subscribe(onNext: { owner, state in
                owner.rootView.setETCTableViewUIUpdate(state: state)
            })
            .disposed(by: disposeBag)
        
        rootView.editButton.rx.tap
            .withUnretained(self)
            .subscribe { onwer, _ in
                onwer.viewModel.pushEditMyPageVC()
            }
            .disposed(by: disposeBag)
        
        viewModel.myPageData
            .withUnretained(self)
            .bind { owner, data in
                owner.rootView.configureMyPageUI(data)
            }
            .disposed(by: disposeBag)
        
        viewModel.checkMyPartyDataRequest()
        viewModel.checkEnteredPartyRequest()
    }
}

extension MyPageViewController: UITableViewDelegate {
    
}

extension MyPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case rootView.aboutPartyTableView:
            return TableViewList.aboutParty.title.count
        case rootView.setPartyTableView:
            return TableViewList.setParty.title.count
        case rootView.setETCTableView:
            return TableViewList.etcParty.title.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.rootView.aboutPartyTableView.dequeueReusableCell(withIdentifier: MyPageTableViewCell.identifier, for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }
        switch tableView {
        case rootView.aboutPartyTableView:
            cell.configureCell(
                title: TableViewList.aboutParty.title[indexPath.row],
                image: TableViewList.aboutParty.image[indexPath.row]
            )
            return cell
        case rootView.setPartyTableView:
            cell.configureCell(
                title: TableViewList.setParty.title[indexPath.row],
                image: TableViewList.setParty.image[indexPath.row]
            )
            return cell
        case rootView.setETCTableView:
            cell.configureCell(
                title: TableViewList.etcParty.title[indexPath.row],
                image: TableViewList.etcParty.image[indexPath.row]
            )
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case rootView.aboutPartyTableView:
            switch indexPath.row {
            case 0:
                viewModel.pushRecentlyVC()
            case 1:
                viewModel.pushMyPartyVC()
            case 2:
                viewModel.pushEnteredPartyVC()
            default:
                break
            }
        case rootView.setPartyTableView:
            switch indexPath.row {
                
            case 2:
                viewModel.presentNotificationSettingVC()
            case 3:
                viewModel.presentLogoutAlertVC()
            default:
                break
            }
            print("setPartyTableView입니다 \(indexPath.row)")
        case rootView.setETCTableView:
            print("setETCTableView입니다 \(indexPath.row)")
            switch indexPath.row {
            case 2:
                viewModel.pushInquireVC()
            default:
                break
            }
        default:
            break
        }
    }
}

extension MyPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dataFetchingToMyPageCell(indexPath: indexPath)
    }
    
    func dataFetchingToMyPageCell(indexPath: IndexPath) {
        let selectedItem = dataSource.snapshot().itemIdentifiers(inSection: 0)[indexPath.row]
        viewModel.input.cellSelected.accept(selectedItem)
    }
}

extension MyPageViewController {
    private func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<MyPageCollectionViewCell, MyPageModel> { cell, indexPath, itemIdentifier in
            cell.configure(itemIdentifier)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: rootView.categoryCollectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
    }
}
