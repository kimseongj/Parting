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
    case setting
    
    var title: [String] {
        switch self {
        case .aboutParty:
            return ["최근 본 파티", "내가 개설한 파티", "내가 참여한 파티"]
        case .setting:
            return ["알림 설정", "이용 약관", "문의하기", "로그아웃"]
        }
    }
    
    var image: [String] {
        switch self {
        case .aboutParty:
            return ["recentlyParty", "myParty", "participate"]
        case .setting:
            return ["bell", "agreement", "mail", "logout"]
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.input.viewWillAppearTrigger.onNext(())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        bind()
        setDataSource()
        setDelegate()
        setDataSourceAndDelegate()
        cellRegister()
        applyPartyCategorySnapshot()
    
    }
    
    private func applyPartyCategorySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, MyPageModel>()
        snapshot.appendSections([0])
        var arr: [MyPageModel] = [MyPageModel(image: UIImage(named: "currentParty")!, title: MyPageCellTitle.current.rawValue), MyPageModel(image: UIImage(named: "createParty")!, title: MyPageCellTitle.create.rawValue), MyPageModel(image: UIImage(named: "participateParty")!, title: MyPageCellTitle.participate.rawValue)]
        snapshot.appendItems(arr)
        self.dataSource.apply(snapshot)
    }
    
    private func setDelegate() {
        rootView.categoryCollectionView.delegate = self
    }
    
    private func cellRegister() {
        rootView.settingTableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.identifier)
    }
    
    private func setDataSourceAndDelegate() {
        tableViewDataSourceAndDelegate(rootView.settingTableView)

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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            viewModel.presentNotificationSettingVC()
        case 1:
            viewModel.pushTermsOfServiceVC()
        case 2:
            viewModel.pushInquireVC()
        case 3:
            viewModel.presentLogoutAlertVC()

        default:
            break
        }
    }
}

extension MyPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableViewList.setting.title.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.rootView.settingTableView.dequeueReusableCell(withIdentifier: MyPageTableViewCell.identifier, for: indexPath) as? MyPageTableViewCell else { return UITableViewCell() }
        cell.fill(title: TableViewList.setting.title[indexPath.row], image: TableViewList.setting.image[indexPath.row])
        cell.selectionStyle = .none
        return cell
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
