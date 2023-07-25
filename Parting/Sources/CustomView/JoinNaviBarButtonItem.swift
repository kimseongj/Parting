//
//  JoinNaviBarButtonItem.swift
//  Parting
//
//  Created by 박시현 on 2023/07/25.
//

import UIKit

class JoinNaviBarButtonItem: UIBarButtonItem {
    override init() {
        super.init()
    }
    
    convenience init(_ action: Selector) {
        self.init()
        self.init(image: UIImage(named: "backBarButton"), style: .plain, target: self, action: action)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
