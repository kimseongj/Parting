//
//  SplahView.swift
//  Parting
//
//  Created by 박시현 on 2023/04/17.
//

import UIKit
import SnapKit

class SplashView: BaseView {
    let introImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "splashImage")
        return image
    }()
    
    let introLabel: UILabel = {
        let label = UILabel()
        label.text = "당신의 소중한 순간을 책임지는\n모임 가이드"
        label.numberOfLines = 0
        label.setLineSpacing()
        label.textAlignment = .center
        label.font = AppleSDGothicNeoFont.Bold.of(size: 20)
        label.textColor = AppColor.white
        return label
    }()
    
    
    
    override func makeConfigures() {
        [introImage, introLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func makeConstraints() {
        introImage.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(Double(105)/Double(375))
            make.height.equalToSuperview().multipliedBy(Double(54.07)/Double(701))
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(UIScreen.main.bounds.size.height * 0.343)
        }
        
        introLabel.snp.makeConstraints { make in
            make.top.equalTo(introImage.snp.bottom).offset(38)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(58)
        }
    }
}
