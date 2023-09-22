//
//  TestHomeViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/09/21.
//

import UIKit

enum PartyList: Int, CaseIterable {
    case 관람팟
    case 자기개발팟
    case 문화생활팟
    case 음식팟
    case 운동팟
    case 오락팟
    case 카페팟
    case 한잔팟
    
    var imageNameList: String {
        switch self {
        case .관람팟:
            return "관람"
        case .자기개발팟:
            return "자기개발"
        case .문화생활팟:
            return "문화생활"
        case .음식팟:
            return "음식"
        case .운동팟:
            return "운동"
        case .오락팟:
            return "오락"
        case .카페팟:
            return "카페"
        case .한잔팟:
            return "술"
        }
    }
    
    static var numberOfItems: Int {
        return Self.allCases.count
    }
}

final class TestHomeViewController: BaseViewController<TestView> {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellResigster()
        setDatasourceAndDelegate()
    }
    
    func cellResigster() {
        rootView.categoryCollectionView.register(TestViewCollectionViewCell.self, forCellWithReuseIdentifier: TestViewCollectionViewCell.identifier)
    }
    
    func setDatasourceAndDelegate() {
        rootView.categoryCollectionView.dataSource = self
    }
}

extension TestHomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PartyList.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestViewCollectionViewCell.identifier, for: indexPath) as? TestViewCollectionViewCell else { return UICollectionViewCell() }
        guard let item = PartyList(rawValue: indexPath.item) else { return UICollectionViewCell() }
        cell.configureCell(item: item)
        
        return cell
    }
    
    
}
