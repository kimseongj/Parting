//
//  InterestsView.swift
//  Parting
//
//  Created by 박시현 on 2023/04/20.
//

import UIKit
import SnapKit

class InterestsView: BaseView {
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    // MARK: - 스크롤뷰 내부에 들어갈 Content View
    // UI 컴포넌트들이 contentView에 들어가야함
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let setThemeLabel: UILabel = {
        let label = UILabel()
        label.text = """
모임 테마를
선택해주세요
"""
        label.numberOfLines = 2
        label.sizeToFit()
        label.font = AppFont.Medium.of(size: 22)
        return label
    }()
    
    let categoryCollectionView: UICollectionView = {
        let itemColumnSpacing: CGFloat = 30
        let sectionSpacing: CGFloat = 32
        let width: CGFloat = (UIScreen.main.bounds.width - (itemColumnSpacing * 2)) - (sectionSpacing * 2)
        let itemWidth: CGFloat = width / 3
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: 110)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 32
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    let nextStepButton = CompleteAndNextButton("다음")
    
    func changeButtonColor(state: Bool) {
        if state {
            nextStepButton.backgroundColor = AppColor.brand
        } else {
            nextStepButton.backgroundColor = AppColor.brandNotValidate
        }
        
    }
    
    override func makeConfigures() {
        super.makeConfigures()
        [setThemeLabel, categoryCollectionView, nextStepButton].forEach {
            contentView.addSubview($0)
        }
        
        scrollView.addSubview(contentView)
        addSubview(scrollView)
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
        
        setThemeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(safeAreaLayoutGuide).inset(24)
            make.width.equalTo(115)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(setThemeLabel.snp.bottom).offset(52)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(400)
        }
        
        nextStepButton.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(38)
        }
    }
}
