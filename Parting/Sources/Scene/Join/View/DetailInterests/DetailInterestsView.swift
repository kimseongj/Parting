//
//  DetailInterestsView.swift
//  Parting
//
//  Created by 박시현 on 2023/06/10.
//

import UIKit
import SnapKit
import RxSwift

class DetailInterestsView: BaseView {
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()

    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let detailCategoryTitle: UILabel = {
        let label = UILabel()
        label.text = """
세부 카테고리를
선택해주세요
"""
        label.numberOfLines = 2
        label.sizeToFit()
        label.font = AppFont.Medium.of(size: 22)
        return label
    }()
    
    let serviceStartButton = CompleteAndNextButton("완료")
    
    private let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .black
        
        return stackView
    }()
    
    func changeCompleteButtonColor(state: Bool) {
        if state {
            serviceStartButton.backgroundColor = AppColor.brand
        } else {
            serviceStartButton.backgroundColor = AppColor.brandNotValidate
        }
    }
    
    func makeDetailInterestsListView(title: String, categoryDetailList: [CategoryDetail]) -> DetailInterestsListView {
        let detailInterestsListView = DetailInterestsListView()
        detailInterestsListView.configureDetailCategoryCollectionView()
        detailInterestsListView.configureCategoryDetailDataSource()
        detailInterestsListView.fill(text: title, categoryDetailList: categoryDetailList)
        
        stackView.addArrangedSubview(detailInterestsListView)
        
        return detailInterestsListView
    }
    
    override func makeConfigures() {
        super.makeConfigures()
        [detailCategoryTitle, stackView, serviceStartButton].forEach {
            contentView.addSubview($0)
        }
        
        scrollView.addSubview(contentView)
        self.addSubview(scrollView)
    }
    
    override func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.height.greaterThanOrEqualTo(self.snp.height).priority(.low)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        detailCategoryTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(safeAreaLayoutGuide).inset(24)
            make.width.equalTo(140)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(detailCategoryTitle.snp.bottom).offset(36)
            make.horizontalEdges.equalToSuperview().inset(25)
        }
        
        serviceStartButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(27)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.872)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(38)
        }
    }
}
