//
//  Kingfisher+Extension.swift
//  Parting
//
//  Created by 김민규 on 2023/07/20.
//

import Foundation
import Kingfisher

extension KF {
	static func saveOnlineImageAtLocalStorage(urlString: String, fileName: String) {
		guard let url = URL(string: urlString) else { return }
		let resource = KF.ImageResource(downloadURL: url)
		
		KingfisherManager.shared.retrieveImage(with: resource) { result in
			switch result {
			case .success(let data):
				let image = data.image
				image.saveImage(imageName: fileName)
			case .failure(let error):
				print(error)
			}
		}
	}
	
	
	
}
