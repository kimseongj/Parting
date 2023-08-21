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


final class MyPageViewController: BaseViewController<MyPageView> {
    
    private var viewModel: MyPageViewModel
    
    init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        bind()
        setDataSourceAndDelegate()
        cellRegister()
        setTableViewHeight()
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
}
