//
//  PartySortingModalViewController.swift
//  Parting
//
//  Created by kimseongjun on 2/13/24.
//

import UIKit
import SnapKit

final class PartySortingModalViewController: UIViewController {
    private let viewModel: PartyListViewModel
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 50
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.417, green: 0.417, blue: 0.417, alpha: 1)
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        label.textAlignment = .center
        label.text = "정렬 기준 선택"
        return label
    }()
    
    private let sortingOptionTableView: MutableSizeTableView = {
        let tableView = MutableSizeTableView()
        tableView.backgroundColor = .gray
        tableView.register(PartySortingTableViewCell.self, forCellReuseIdentifier: PartySortingTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private let partitionLine: UIView = {
        let view = UIView()
        view.layer.borderColor = AppColor.gray50.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("닫기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapDismissButton), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func tapDismissButton() {
        self.dismiss(animated: false)
    }
    
    //MARK: - Init
    
    init(viewModel: PartyListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureFilterTableView()
    }
    
    //MARK: - ConfigureUI()
    
    private func configureUI() {
        view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let safeArea = view.safeAreaLayoutGuide
        view.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(sortingOptionTableView)
        contentView.addSubview(dismissButton)
        contentView.addSubview(partitionLine)
        
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.centerX.equalToSuperview()
        }
        
        sortingOptionTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
        
        partitionLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(sortingOptionTableView.snp.bottom).offset(1)
            $0.leading.trailing.equalToSuperview()
        }
        
        dismissButton.snp.makeConstraints {
            $0.top.equalTo(partitionLine.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeArea.snp.bottom)
            $0.height.equalTo(60)
        }
    }
}

//MARK: - ConfigureTableView

extension PartySortingModalViewController {
    private func configureFilterTableView() {
        sortingOptionTableView.dataSource = self
        sortingOptionTableView.delegate = self
    }
}

//MARK: - FilterTableView DataSource

extension PartySortingModalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.sortingOptionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PartySortingTableViewCell.identifier, for: indexPath) as! PartySortingTableViewCell
        cell.fill(with: viewModel.output.sortingOptionList[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
}

//MARK: - FilterTableView Delegate

extension PartySortingModalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let previousSelectedIndexPath = viewModel.output.selectedSortingOptionIndexPath {
            tableView.cellForRow(at: previousSelectedIndexPath)?.isSelected = false
        }
        
        tableView.cellForRow(at: indexPath)?.isSelected = true
        viewModel.output.selectedSortingOptionIndexPath = indexPath
        viewModel.input.currentSortingOptionRelay.accept(viewModel.output.sortingOptionList[indexPath.row])
        viewModel.sortPartyList()
    }
}
