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
	
	func saveImage(imageName: String) {

	 guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

		let fileName = imageName
		let fileURL = documentsDirectory.appendingPathComponent(fileName)
		guard let data = self.jpegData(compressionQuality: 1) else { return }

		//Checks if file exists, removes it if so.
		if FileManager.default.fileExists(atPath: fileURL.path) {
			do {
				try FileManager.default.removeItem(atPath: fileURL.path)
				print("Removed old image")
			} catch let removeError {
				print("couldn't remove file at path", removeError)
			}

		}

		do {
			try data.write(to: fileURL)
		} catch let error {
			print("error saving file with error", error)
		}

	}
	
	
	static func loadImageFromDiskWith(fileName: String) -> UIImage? {

	  let documentDirectory = FileManager.SearchPathDirectory.documentDirectory

		let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
		let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)

		if let dirPath = paths.first {
			let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
			let image = UIImage(contentsOfFile: imageUrl.path)
			return image

		}

		return nil
	}
	
	
}

