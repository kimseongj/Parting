//
//  StartWithLoginView.swift
//  Parting
//
//  Created by kimseongjun on 1/16/24.
//

import UIKit
import RxSwift
import RxCocoa

final class StartWithLoginView: BaseView {
    private let startLabel: UILabel = {
        let label = UILabel()
        label.text = """
반갑습니다!
팟팅을 시작해볼까요?
"""
        label.numberOfLines = 2
        label.sizeToFit()
        label.font = AppFont.Medium.of(size: 22)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundTheme")
        
        return imageView
    }()
    
    let nextStepButton = CompleteAndNextButton("시작하기")
    
    override func makeConfigures() {
        super.makeConfigures()
        nextStepButton.layer.backgroundColor = AppColor.brand.cgColor
        [startLabel, imageView, nextStepButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func makeConstraints() {
        startLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(UIScreen.main.bounds.height * 0.13)
            make.leading.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(UIScreen.main.bounds.width * 0.9)
            make.height.equalTo(UIScreen.main.bounds.height * 0.7)
            make.width.equalTo(UIScreen.main.bounds.height * 0.7 * 0.83)
            make.bottom.equalTo(nextStepButton.snp.top)
        }
        
        nextStepButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(38)
        }
    }
}
