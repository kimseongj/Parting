//
//  LogoutView.swift
//  Parting
//
//  Created by 이병현 on 2023/09/22.
//

import UIKit
import SnapKit

final class LogoutAlertView: BaseView {
    
    let alertView: CustomTwoButtonAlertView = {
        let view = CustomTwoButtonAlertView(title: "로그아웃 하시겠습니까?")
        return view
    }()
    
    override func makeConfigures() {
        super.makeConfigures()
        
        self.addSubview(alertView)
    }
    
    override func makeConstraints() {
        
        alertView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        alertView.backgroundColor = .clear
    }
}
