//
//  ScheduleCalendarViewController.swift
//  Parting
//
//  Created by kimseongjun on 1/25/24.
//

import UIKit
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
        configureCollectionView()
        hideNoPartyView()
        configureMonth()
    }
    
    override func viewDidLayoutSubviews() {
        rootView.makeDotLine()
        rootView.makeClendarViewShadow()
        rootView.makeNoPartyView()
    }
    
    deinit {
        print("ScheduleCalendarVC 메모리 해제")
    }
    
    private func configureMonth() {
        rootView.monthLabel.text = viewModel.fetchNowMonth()
    }
    
    private func configureCollectionView() {
        rootView.scheduleCollectionView.dataSource = self
    }
    
    private func bindScheduleCollectionView() {
        
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
}

extension ScheduleCalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCell.identifier, for: indexPath) as? ScheduleCell else { return UICollectionViewCell() }
        return cell
    }
}
