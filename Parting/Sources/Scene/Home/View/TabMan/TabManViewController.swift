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
    private var tabControllers: [UIViewController] = []
    private let bar = TMBar.ButtonBar()
    private let navigationTitle = BarTitleLabel(text: "무슨무슨팟")
    private var backBarButton = BarImageButton(imageName: Images.icon.back)
    private let disposeBag = DisposeBag()
    private let viewModel: TabManViewModel
    
    init(firstVC: UIViewController, secondVC: UIViewController, thirdVC: UIViewController, fourthVC: UIViewController, title: String, viewModel: TabManViewModel) {
        tabControllers.append(firstVC)
        tabControllers.append(secondVC)
        tabControllers.append(thirdVC)
        tabControllers.append(fourthVC)
        self.viewModel = viewModel
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
        configureTabmanBar()
        self.dataSource = self
        bind()
    }
    
    func configureTabmanBar() {
        bar.layout.transitionStyle = .snap
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        bar.layout.interButtonSpacing = 23
        
        bar.backgroundView.style = .clear
        bar.backgroundColor = AppColor.white
        
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
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
                owner.viewModel.input.onNext(.backButtonTap)
            })
            .disposed(by: disposeBag)
    }
}


extension TabManViewController: PageboyViewControllerDataSource {
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return tabControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return tabControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return nil
    }
}

extension TabManViewController: TMBarDataSource {
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "전체보기")
        case 1:
            return TMBarItem(title: "스터디")
        case 2:
            return TMBarItem(title: "책/독서")
        case 3:
            return TMBarItem(title: "클래스 수강")
        default:
            break
        }
        return TMBarItem(title: "")
    }
}
