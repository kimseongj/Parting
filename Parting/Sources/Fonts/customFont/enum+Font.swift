//
//  enum+Font.swift
//  Parting
//
//  Created by 박시현 on 2023/03/23.
//

import UIKit

enum notoSansFont: String, CaseIterable {
    case Black = "NotoSansKR-Black"
    case Bold = "NotoSansKR-Bold"
    case Light = "NotoSansKR-Light"
    case Medium = "NotoSansKR-Medium"
    case Regular = "NotoSansKR-Regular"
    case Thin = "NotoSansKR-Thin"
    
    func of(size: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: size)!
    }
}

