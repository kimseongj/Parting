//
//  StyledNavigationController.swift
//  Parting
//
//  Created by 김민규 on 2023/05/14.
//

import UIKit

class StyledNavigationController: UINavigationController {
	func disableDefaultSettings() {
		let appearance = navigationBar.standardAppearance
		appearance.configureWithTransparentBackground()
		navigationBar.isTranslucent = false
	}
	
	private func changeBackgroundColor(_ color: UIColor) {
		let appearance = navigationBar.standardAppearance
//		appearance.backgroundColor = .background
		UINavigationBar.appearance().standardAppearance = appearance
		UINavigationBar.appearance().compactAppearance = appearance
		UINavigationBar.appearance().scrollEdgeAppearance = appearance
	}
	
	private func changeShadowColor(_ color: UIColor) {
		let appearance = navigationBar.standardAppearance
		appearance.shadowColor = color
		UINavigationBar.appearance().standardAppearance = appearance
	}
	
	private func changeTintColor(_ color: UIColor) {
		navigationBar.tintColor = color
	}
	
	private func changeNavigationTitleStyle(color: UIColor, font: UIFont) {
		var textAttributes = navigationBar.standardAppearance.titleTextAttributes
		textAttributes[.foregroundColor] = color
		textAttributes[.font] = font
		navigationBar.titleTextAttributes = textAttributes
	}

	
	private func setupAppearance() {
//		disableDefaultSettings()
		changeBackgroundColor(.white)
		changeShadowColor(.separator)
//		changeTintColor(.primary)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupAppearance()
		
	}


}
