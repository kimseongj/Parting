//
//  UIImage+Extension.swift
//  Parting
//
//  Created by 김민규 on 2023/07/01.
//

import UIKit

extension UIImage {
	func resized(to size: CGSize) -> UIImage {
		return UIGraphicsImageRenderer(size: size).image { _ in
			draw(in: CGRect(origin: .zero, size: size))
		}
	}
}
