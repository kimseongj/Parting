//
//  TabManViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/09/29.
//

import UIKit
import Tabman
import Pageboy
import RxSwift
import RxCocoa

final class TabManViewController: TabmanViewController {
    private let tabView = UIView()
    private let bar = TMBar.ButtonBar()
    private let navigationTitle = BarTitleLabel(text: "무슨무슨팟")
    private var backBarButton = BarImageButton(imageName: Images.icon.back)
    private let disposeBag = DisposeBag()
    private let tabManDatasource: TabManDataSource
    
    init(title: String, tabManDatasource: TabManDataSource) {
        self.tabManDatasource = tabManDatasource
        super.init(nibName: nil, bundle: nil)
        navigationTitle.text = title
        self.navigationItem.leftBarButtonItem = backBarButton
        self.navigationItem.titleView = navigationTitle
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabManDatasource.input.onNext(.viewDidLoad)
        configureTabmanBar()
        self.view.backgroundColor = .white
        self.dataSource = self
        bind()
    }
    
    func configureTabmanBar() {
        bar.layout.transitionStyle = .snap
        bar.layout.alignment = .leading
        bar.layout.contentMode = .intrinsic
        bar.layout.interButtonSpacing = 23
        
        bar.backgroundView.style = .clear
        bar.backgroundColor = AppColor.white
        
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        
        bar.buttons.customize { button in
            button.tintColor = AppColor.gray300
            button.font = AppFont.Medium.of(size: 14)
            button.selectedTintColor = AppColor.gray900
        }
        
        bar.indicator.weight = .custom(value: 2)
        bar.indicator.overscrollBehavior = .bounce
        bar.indicator.tintColor = AppColor.brand
        
        addBar(bar, dataSource: self, at: .top)
    }
    
    func bind() {
        backBarButton.innerButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, tap in
                owner.tabManDatasource.input.onNext(.backButtonTap)
            })
            .disposed(by: disposeBag)
        
        tabManDatasource.output
            .withUnretained(self)
            .subscribe(onNext: { owner, output in
                owner.reloadData()
            })
            .disposed(by: disposeBag)
    }
}


extension TabManViewController: PageboyViewControllerDataSource {
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return tabManDatasource.tabControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return tabManDatasource.tabControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return nil
    }
}

extension TabManViewController: TMBarDataSource {
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        return TMBarItem(title: tabManDatasource.tabTitle[index])
    }
}
