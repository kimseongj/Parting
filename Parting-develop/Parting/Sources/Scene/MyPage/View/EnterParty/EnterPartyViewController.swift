//
//  EnterPartyViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/08/22.
//

import UIKit
import RxSwift
import RxCocoa

class EnterPartyViewController: BaseViewController<MypageCommonView>, MyPageProtocol {
    
    private let viewModel: EnterPartyViewModel
    
    init(viewModel: EnterPartyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        cellRegister()
        setTableViewDelegateAndDataSource()
        bind()
    }
    
    deinit {
        print("EnterPartyVC 메모리에서 해제되었습니다.")
    }
    
    private func navigationUI() {
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.rightBarButtonItem = rootView.bellBarButton
        self.navigationItem.leftBarButtonItem = rootView.backBarButton
        self.navigationItem.titleView = BarTitleLabel(text: "내가 참여한 파티")
    }
    
    func cellRegister() {
        rootView.partyListTableView.register(PartyTableViewCell.self, forCellReuseIdentifier: PartyTableViewCell.identifier)
        
    }
    
    func setTableViewDelegateAndDataSource() {
        rootView.partyListTableView.delegate = self
        rootView.partyListTableView.dataSource = self
    }
    
    private func bind() {
        rootView.backBarButton.innerButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.viewModel.input.accept(.popCurrentVC)
            })
            .disposed(by: disposeBag)
        

    }
}

extension EnterPartyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "나가기") { (_, _, success: @escaping(Bool) -> Void) in
            tableView.beginUpdates()
            self.viewModel.input.accept(.deleteParty(row: indexPath.row))
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            success(true)
        }
        delete.backgroundColor = AppColor.brand
        delete.image = UIImage(named: "deleteParty")
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

extension EnterPartyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.myPartyList.count)
        return viewModel.myPartyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = rootView.partyListTableView.dequeueReusableCell(withIdentifier: PartyTableViewCell.identifier) as? PartyTableViewCell else { return UITableViewCell() }
        cell.configureMyPageCell(party: viewModel.myPartyList[indexPath.row])
        print()
        return cell
    }
}
