//
//  PartyDetailInfoViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/08/30.
//

// MARK: 어떤 유저인지에 따라서 보여지는 뷰가 달라야 함
enum PartyDetailInfoViewType: String {
    case host = "HOST"
    case participants = "zz"
    case nonParticipants = "zzz"
}

import UIKit
import RxSwift
import RxCocoa

class PartyDetailInfoViewController: BaseViewController<PartyDetailInfoView> {
    private let viewModel: PartyDetailInfoViewModel
    var mockDataPersonnel: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: ["철수", "영희", "영호", "선욱", "인심", "정우", "병현", "강호", "수지"])
    var imageList: [String] = ["https://parting-dev.s3.ap-northeast-2.amazonaws.com/categoryImage/%EC%9E%90%EA%B8%B0%EA%B0%9C%EB%B0%9C%ED%8C%9F.png", "https://parting-dev.s3.ap-northeast-2.amazonaws.com/categoryImage/%EC%9E%90%EA%B8%B0%EA%B0%9C%EB%B0%9C%ED%8C%9F.png", "https://parting-dev.s3.ap-northeast-2.amazonaws.com/categoryImage/%EC%9E%90%EA%B8%B0%EA%B0%9C%EB%B0%9C%ED%8C%9F.png", "https://parting-dev.s3.ap-northeast-2.amazonaws.com/categoryImage/%EC%9E%90%EA%B8%B0%EA%B0%9C%EB%B0%9C%ED%8C%9F.png", "https://parting-dev.s3.ap-northeast-2.amazonaws.com/categoryImage/%EC%9E%90%EA%B8%B0%EA%B0%9C%EB%B0%9C%ED%8C%9F.png", "https://parting-dev.s3.ap-northeast-2.amazonaws.com/categoryImage/%EC%9E%90%EA%B8%B0%EA%B0%9C%EB%B0%9C%ED%8C%9F.png", "https://parting-dev.s3.ap-northeast-2.amazonaws.com/categoryImage/%EC%9E%90%EA%B8%B0%EA%B0%9C%EB%B0%9C%ED%8C%9F.png", "https://parting-dev.s3.ap-northeast-2.amazonaws.com/categoryImage/%EC%9E%90%EA%B8%B0%EA%B0%9C%EB%B0%9C%ED%8C%9F.png", "https://parting-dev.s3.ap-northeast-2.amazonaws.com/categoryImage/%EC%9E%90%EA%B8%B0%EA%B0%9C%EB%B0%9C%ED%8C%9F.png"]
    
    var mockDataCategoryName: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: ["방탈출", "영화"])
    
    var mockDataHashTagName: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: ["#카공", "#공무원", "#국가고시"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.input.onNext(.viewDidLoadTrigger)
        registerCell()
        bind()
    }
    
    init(viewModel: PartyDetailInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerCell() {
        rootView.partyPersonnelCollectionView.register(PersonnelCollectionViewCell.self, forCellWithReuseIdentifier: PersonnelCollectionViewCell.identifier)
        
        rootView.partyTypeCollectionView.register(PartyTypeCollectionViewCell.self, forCellWithReuseIdentifier: PartyTypeCollectionViewCell.identifier)
        
        rootView.hashTagCategoryCollectionView.register(HashTagCollectionViewCell.self, forCellWithReuseIdentifier: HashTagCollectionViewCell.identifier)
    }
    
    private func bind() {
        viewModel.perssonalDataList
            .bind(to: rootView.partyPersonnelCollectionView.rx.items(cellIdentifier: PersonnelCollectionViewCell.identifier, cellType: PersonnelCollectionViewCell.self)) { [weak self] index, personnel, cell in
                DispatchQueue.main.async {
                    cell.configureCell(data: personnel)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.partyTypeDataList
            .bind(to: rootView.partyTypeCollectionView.rx.items(cellIdentifier: PartyTypeCollectionViewCell.identifier, cellType: PartyTypeCollectionViewCell.self)) { [weak self] index, partyType, cell in
                cell.configureCell(name: partyType)
            }
            .disposed(by: disposeBag)
        
        viewModel.hashTagDataList
            .bind(to: rootView.hashTagCategoryCollectionView.rx.items(cellIdentifier: HashTagCollectionViewCell.identifier, cellType: HashTagCollectionViewCell.self)) { [weak self] index, hashtag, cell in
                cell.configureCell(name: hashtag)
            }
            .disposed(by: disposeBag)
        
        viewModel.ouput
            .withUnretained(self)
            .subscribe(onNext: { owner, output in
                switch output {
                case .detailPartyResponseData:
                    guard let partyDetailData = owner.viewModel.partyDetailData else { return }
                    owner.rootView.configureViews(data: partyDetailData, type: "NORMAL_MEMBER")
                }
            })
            .disposed(by: disposeBag)
        
        rootView.partyPersonnelCollectionView.rx.modelSelected(PartyMemberList.self)
            .withUnretained(self)
            .subscribe(onNext: { owner, model in
                owner.viewModel.input.onNext(.perssonelInfo(userId: model.userID))
            })
            .disposed(by: disposeBag)
    }
}
