//
//  MypageCommonView.swift
//  Parting
//
//  Created by 박시현 on 2023/08/23.
//

import UIKit
import SnapKit

class MypageCommonView: BaseView {
    let bellBarButton = BarImageButton(imageName: Images.sfSymbol.bell)
    let navigationLabel = BarTitleLabel(text: "무슨무슨팟")
    var backBarButton = BarImageButton(imageName: Images.icon.back)
    
    let partyListTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    override func makeConfigures() {
        super.makeConfigures()
        addSubview(partyListTableView)
    }
    
    override func makeConstraints() {
        partyListTableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalToSuperview()
        }
    }
}
