//
//  UITabBarController+Extension.swift
//  Parting
//
//  Created by 김민규 on 2023/07/20.
//

import Foundation
import UIKit

extension UITabBarController {
	func setTabBarVisible(visible: Bool, duration: TimeInterval, animated: Bool) {
		if tabBarIsVisible() == visible { return }

		let frame = tabBar.frame
		let height = frame.size.height
		let offsetY = (visible ? -height : height)

		// Update the tab bar's frame
		tabBar.frame = frame.offsetBy(dx: 0, dy: offsetY)

		// If you want to animate the change
		if animated {
			UIView.animate(withDuration: duration, delay: 0, options: .curveLinear) {
				self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height + offsetY)
			} completion: { _ in
				self.view.setNeedsLayout()
			}
		} else {
			// If not animating, just update the frame directly
			self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height + offsetY)
			self.view.setNeedsLayout()
		}
	}

	func tabBarIsVisible() -> Bool {
		return tabBar.frame.origin.y < UIScreen.main.bounds.height
	}
}
