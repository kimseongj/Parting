//
//  HomeView.swift
//  Parting
//
//  Created by 김민규 on 2023/05/09.
//
import UIKit
import SnapKit
import FSCalendar

class HomeView: BaseView {
	let bellBarButton = BarImageButton(imageName: Images.sfSymbol.bell)
	
	let searchBar: UISearchBar = {
		let bar = UISearchBar()
		bar.placeholder = "세부 카테고리 검색"
		bar.backgroundImage = UIImage()
		return bar
	}()
	
	let navigationLabel = BarTitleLabel(text: "팟팅")
	
	let mainStackView: UIStackView = {
		let view = StackView(axis: .vertical, alignment: .firstBaseline, distribution: .equalSpacing, spacing: 8.0)
		view.backgroundColor = .white
		return view
	}()

	let scheduleStackView: UIStackView = {
		let view = StackView(axis: .horizontal, alignment: .leading, distribution: .equalSpacing, spacing: 20.0)
		return view
	}()
	
	let calendarWidget: CalendarWidgetView = {
		let widget = CalendarWidgetView()
		return widget
	}()
    
//    let calendarWidget: UIButton = {
//        let widget = CalendarWidgetView()
//        return widget
//    }()
	
	let dDayWidget: DdayWidgetView = {
        let view = DdayWidgetView()
						  
		view.backgroundColor = .white
		return view
	}()
	
	let categoryCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
		return collectionView
	}()
	
	override func makeConfigures() {
		self.backgroundColor = .white
		
		addSubview(mainStackView)
		mainStackView.addArrangedSubview(searchBar)
		mainStackView.addArrangedSubview(scheduleStackView)
		scheduleStackView.addArrangedSubview(calendarWidget)
		scheduleStackView.addArrangedSubview(dDayWidget)
		
		mainStackView.addArrangedSubview(categoryCollectionView)
	}
	
	override func makeConstraints() {

		mainStackView.snp.makeConstraints { make in
			make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(8)
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		searchBar.snp.makeConstraints { make in
			make.right.equalToSuperview().offset(-8)
			make.left.equalToSuperview().offset(8)
		}
		
		scheduleStackView.snp.makeConstraints { make in
			make.left.equalToSuperview().offset(16)
			make.right.equalToSuperview().offset(-16)
		}
		
		mainStackView.setCustomSpacing(20.0, after: scheduleStackView)
		
		let screenWidth = UIScreen.main.bounds.width
		let totalPadding = 32.0 + 20.0
		let widgetWidth = screenWidth - totalPadding
		let widgetWidthMultiplier = widgetWidth / screenWidth / 2

		calendarWidget.snp.makeConstraints { make in
			make.width.equalTo(snp.width).multipliedBy(widgetWidthMultiplier)
			make.height.equalTo(calendarWidget.snp.width)
		}

		dDayWidget.snp.makeConstraints { make in
			make.width.equalTo(snp.width).multipliedBy(widgetWidthMultiplier)
			make.height.equalTo(dDayWidget.snp.width)
		}

		categoryCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
			make.height.equalTo(230)
		}
	}
}

extension HomeView {
    func configureView(widgetData: WidgetResult) {
        // 여기서 날짜 데이터 받기
        dDayWidget.dDay = widgetData.dday
        dDayWidget.meetingName = widgetData.partyName
    }
    
    func receiveData(calendarDays: [Int]) {
//        let testView = CalendarWidgetView() // 새로운 인스턴스 생성
//        testView.receiveCalendarDays(calendarDays: calendarDays)
        
        calendarWidget.receiveCalendarDays(calendarDays: calendarDays)
    }
}

