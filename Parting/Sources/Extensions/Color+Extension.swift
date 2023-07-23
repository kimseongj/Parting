//
//  Color.swift
//  Parting
//
//  Created by 박시현 on 2023/03/27.
//

import UIKit

// MARK: - Hex color로 변환하는 코드
extension UIColor {
    convenience init(hexcode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexcode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

enum AppColor {
    static let brand: UIColor = UIColor(hexcode: "F85376")
    static let kakaoButton: UIColor = UIColor(hexcode: "FEE500")
    static let onboardingBackground: UIColor = UIColor(hexcode: "F85276")
    static let gray100: UIColor = UIColor(hexcode: "F8FAFD")
    static let gray200: UIColor = UIColor(hexcode: "F2F2F5")
    static let gray300: UIColor = UIColor(hexcode: "ECECEC")
    static let gray400: UIColor = UIColor(hexcode: "D9D9E2")
    static let gray500: UIColor = UIColor(hexcode: "D9D9D9")
	static let gray600: UIColor = UIColor(hexcode: "868686")
    static let baseText: UIColor = UIColor(hexcode: "000000")
    static let joinText: UIColor = UIColor(hexcode: "1D232E")
    static let white: UIColor = UIColor(hexcode: "FFFFFF")
	static let lightPink: UIColor = UIColor(hexcode: "FFC7C7")
}
