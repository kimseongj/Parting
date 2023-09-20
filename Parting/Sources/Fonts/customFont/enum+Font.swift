//
//  enum+Font.swift
//  Parting
//
//  Created by 박시현 on 2023/03/23.
//

import UIKit

enum AppFont: String, CaseIterable {
    case Bold = "AppleSDGothicNeo-Bold"
    case SemiBold = "AppleSDGothicNeo-SemiBold"
    case Light = "AppleSDGothicNeo-Light"
    case Medium = "AppleSDGothicNeo-Medium"
    case Regular = "AppleSDGothicNeo-Regular"
    case Thin = "AppleSDGothicNeo-Thin"
    case UltraLight = "AppleSDGothicNeo-UltraLight"
    
    func of(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: 13)
    }
}

