//
//  SortingOptionModalViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/08/17.
//

//import UIKit
//import SnapKit
//import RxSwift
//
//class SortingOptionModalViewController: UIViewController {
//
//    private let disposeBag = DisposeBag()
//    
//    private var viewModel: PartyListViewModel?
//    
//    private var sortingOption: SortingOption?
//    
//    private let mainVStack = StackView(axis: .vertical, alignment: .leading, distribution: .equalSpacing, spacing: 48)
//    
//    let titleLabel = Label(text: "정렬 기준 선택", weight: .Bold, size: 20)
//    
//    let defaultSortingOptionRadio: RadioButton = {
//        let button = RadioButton(text: "인원 기본 순", weight: .Medium, textSize: 16)
//
//        return button
//    }()
//    
//    let sortingCondition1Radio = RadioButton(text: "인원 많은 순", weight: .Medium, textSize: 20)
//    
//    let sortingCondition2Radio = RadioButton(text: "인원 적은 순", weight: .Medium, textSize: 20)
//    
//    lazy var group: [RadioButton] = [defaultSortingOptionRadio, sortingCondition1Radio, sortingCondition2Radio]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//        addSubviews()
//        makeConstraints()
//        configureRadios()
//        setupBindings()
//    }
//    
//    convenience init(viewModel: PartyListViewModel, for sortingOption: SortingOption) {
//        self.init()
//        self.viewModel = viewModel
//        self.sortingOption = sortingOption
//        switch sortingOption {
//        case .numberOfPeople:
//            configureText(defaultCondition: "인원 기본 순", condition1: "인원 많은 순", condition2: "인원 적은 순")
//            group[SortingOption.numberOfPeople(viewModel.output.currentSortingOption1.value).index].isChecked = true
//            break
//        case .time:
//            configureText(defaultCondition: "거리 순", condition1: "마감 시간 순", condition2: "최근 개설 순")
//            group[SortingOption.time(viewModel.output.currentSortingOption2.value).index].isChecked = true
//            break
//        }
//        
//        
//        
//        
//    }
//    
//    private func configureText(defaultCondition: String, condition1: String, condition2: String) {
//        defaultSortingOptionRadio.setTitle(defaultCondition, for: .normal)
//        sortingCondition1Radio.setTitle(condition1, for: .normal)
//        sortingCondition2Radio.setTitle(condition2, for: .normal)
//    }
//    
//    private func configureRadios() {
//        for radio in group {
//            radio.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
//        }
//    }
//    
//    @objc
//    private func buttonTapped(sender: RadioButton) {
//        for radio in group {
//            radio.isChecked = false
//        }
//        
//        sender.isChecked = true
//    }
//    
//    private func setupBindings() {
//        guard let viewModel = viewModel, let sortingOption = sortingOption else { return }
//        
//    
//        
//        
//        
//        for (index, radio) in group.enumerated() {
//            radio.rx.tap.subscribe(onNext: { [weak self] in
//                self?.dismiss(animated: true)
//                
//            }).disposed(by: disposeBag)
//            
//            radio.rx.tap.map({ _ in
//                switch sortingOption {
//                case .numberOfPeople(_):
//                    switch index {
//                    case SortingOption.numberOfPeople(.few).index:
//                        return SortingOption.numberOfPeople(.few)
//                    case SortingOption.numberOfPeople(.many).index:
//                        return SortingOption.numberOfPeople(.many)
//                    default:
//                        return SortingOption.numberOfPeople(.none)
//                    }
//                case .time(_):
//                    switch index {
//                    case SortingOption.time(.closest).index:
//                        return SortingOption.time(.closest)
//                    case SortingOption.time(.closingTime).index:
//                        return SortingOption.time(.closingTime)
//                    case SortingOption.time(.latest).index:
//                        return SortingOption.time(.latest)
//                    default:
//                        return sortingOption
//                    }
//                }
//            
//            })
//                .bind(to: viewModel.input.updateSortingOptionTrigger)
//                .disposed(by: disposeBag)
//        }
//    }
//
//}
//
//extension SortingOptionModalViewController: ProgrammaticallyInitializableViewProtocol {
//    func setupView() {
//        view.backgroundColor = AppColor.white
//    }
//    
//    func addSubviews() {
//        view.addSubview(titleLabel)
//        view.addSubview(mainVStack)
//        mainVStack.addArrangedSubview(defaultSortingOptionRadio)
//        mainVStack.addArrangedSubview(sortingCondition1Radio)
//        mainVStack.addArrangedSubview(sortingCondition2Radio)
//    }
//    
//    func makeConstraints() {
//        titleLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalToSuperview().offset(36)
//        }
//        
//        mainVStack.snp.makeConstraints { make in
//            make.right.equalToSuperview().offset(-16)
//            make.left.equalToSuperview().offset(16)
//            
//            make.top.equalTo(titleLabel.snp.bottom).offset(48)
//        }
//    }
//    
//
//}
