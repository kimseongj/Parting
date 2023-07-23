////
////  DetailInterestsViewModel.swift
////  Parting
////
////  Created by 박시현 on 2023/06/10.
////
//
//import UIKit
//import RxSwift
//import RxCocoa
//
//protocol DetailInterestsViewProtocol {
//	func serviceStartButtonClicked()
//}
//
//class DetailInterestsViewModel: BaseViewModel, DetailInterestsViewProtocol {
//
//	struct Input {
//		let popDetailInterestsViewTrigger: PublishSubject<Void> = PublishSubject()
//	}
//
//	struct Output {
//	}
//
//	var input: Input
//	var output: Output
//	var count: BehaviorRelay<[Int]>
//	var categoryNameList: BehaviorRelay<[String]>
//	var associatedNameList: BehaviorRelay<[[String]]>
//
//	private weak var coordinator: JoinCoordinator?
//
//	private let disposeBag = DisposeBag()
//
//	init(input: Input = Input(), output: Output = Output(), coordinator: JoinCoordinator, cellList: [Int], categoryNameList: [String], associatedNameList: [[String]]) {
//		self.input = input
//		self.output = output
//		self.coordinator = coordinator
//		self.count = BehaviorRelay(value: cellList)
//		self.categoryNameList = BehaviorRelay(value: categoryNameList)
//		self.associatedNameList = BehaviorRelay(value: associatedNameList)
//		viewChangeTrigger()
//	}
//
//	func serviceStartButtonClicked() {
//		print("버튼 Action 호출중")
////        self.coordinator?.delegate?.startMainFlow()
//		print(coordinator)
//		print(coordinator?.delegate)
//		(self.coordinator?.delegate as? AppCoordinator)?.connectMainFlow()
//	}
//
//	private func viewChangeTrigger() {
//		input.popDetailInterestsViewTrigger
//			.subscribe(onNext: {[weak self] _ in
//				self?.popDetailInterestsViewController()
//			})
//			.disposed(by: disposeBag)
//	}
//
//	private func popDetailInterestsViewController() {
//		self.coordinator?.popDetailInterestsViewController()
//	}
//}
//
//import UIKit
//// join -> appcoordi 접근 Delegate
//
//final class JoinCoordinator: Coordinator {
//	weak var delegate: CoordinatorDelegate?
//	var childCoordinators = [Coordinator]()
//	var navigationController: UINavigationController
//	var type: CoordinatorStyleCase = .join
//
//	init(_ navigationController: UINavigationController) {
//		self.navigationController = navigationController
//	}
//
//	func start() {
//		showSplashViewController()
//	}
//
//	func showSplashViewController() {
//		let viewModel = SplashViewModel(coordinator: self)
//		let vc = SplashViewController(viewModel: viewModel)
//		navigationController.viewControllers = [vc]
//	}
