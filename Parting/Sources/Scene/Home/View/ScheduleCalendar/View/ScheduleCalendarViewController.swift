//
//  ScheduleCalendarViewController.swift
//  Parting
//
//  Created by kimseongjun on 1/25/24.
//

import UIKit
import RxSwift
import RxCocoa
import FSCalendar

final class ScheduleCalendarViewController: BaseViewController<ScheduleCalendarView> {
    private var viewModel: ScheduleCalendarViewModel
    
    init(viewModel: ScheduleCalendarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindDismissButton()
        hideNoPartyView()
        configureMonth()
        configureDataSourceAndDelegate()
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        rootView.makeDotLine()
        rootView.makeClendarViewShadow()
        rootView.configureNoPartyView()
    }
    
    deinit {
        print("ScheduleCalendarVC 메모리 해제")
    }
    
    private func configureMonth() {
        rootView.monthLabel.text = DateFormatterManager.dateFormatter.makeYearMonthDate(date: Date())
    }
    
    private func bind() {
        bindCalendarEvent()
        bindScheduleCollectionView()
    }
    
    private func bindCalendarEvent() {
        viewModel.output.partyDateListRelay.withUnretained(self).bind(onNext: {owner, _ in
            owner.rootView.calendarView.reloadData()
        })
        .disposed(by: disposeBag)
    }
    
    private func bindScheduleCollectionView() {
        viewModel.output.partyListRelay
            .bind(to: rootView.scheduleCollectionView.rx.items(cellIdentifier: ScheduleCell.identifier, cellType: ScheduleCell.self)) { index, partyInfo, cell in
                cell.fill(with: partyInfo)
        }
        .disposed(by: disposeBag)
        
        viewModel.output.hasPartyRelay
            .withUnretained(self)
            .bind(onNext: { owner, hasParty in
                if hasParty {
                    owner.hideNoPartyView()
                } else {
                    owner.hideScheduleCollectionView()
                }
            }).disposed(by: disposeBag)
    }
    
    private func hideScheduleCollectionView() {
        rootView.scheduleCollectionView.isHidden = true
        rootView.scheduleCollectionBackgroundView.isHidden = true
        rootView.noPartyView.isHidden = false
    }
    
    private func hideNoPartyView() {
        rootView.scheduleCollectionView.isHidden = false
        rootView.scheduleCollectionBackgroundView.isHidden = false
        rootView.noPartyView.isHidden = true
    }
    
    private func bindDismissButton() {
        rootView.dismissButton.addTarget(self, action: #selector(tapDismissButton), for: .touchUpInside)
    }
    
    @objc
    private func tapDismissButton() {
        self.dismiss(animated: true)
    }
    
    private func configureDataSourceAndDelegate() {
        rootView.calendarView.dataSource = self
        rootView.calendarView.delegate = self
    }
}

extension ScheduleCalendarViewController: FSCalendarDelegate {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let currentDate = rootView.calendarView.currentPage
        let formattedMonth = DateFormatterManager.dateFormatter.makeYearMonthDate(date: currentDate)
        rootView.monthLabel.text = formattedMonth
        viewModel.fetchPartyDetails(date: currentDate)
    }
}

extension ScheduleCalendarViewController: FSCalendarDataSource {
func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
    if viewModel.output.partyDateListRelay.value.contains(date){
        return 1
    }
    return 0
}
}

extension ScheduleCalendarViewController: FSCalendarDelegateAppearance {
func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
    if viewModel.output.partyDateListRelay.value.contains(date) {
        return AppColor.brand
    } else {
        return nil
    }
}
}
