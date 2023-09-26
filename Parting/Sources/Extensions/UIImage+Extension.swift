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

extension UIImage {
    func resizeImageTo(size: CGSize) -> UIImage? {
        // 비트맵 생성
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        // 비트맵 그래픽 배경에 이미지 다시 그리기
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        // 현재 비트맵 그래픽 배경에서 이미지 가져오기
        guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        // 비트맵 환경 제거
        UIGraphicsEndImageContext()
        // 크기가 조정된 이미지 반환
        return resizedImage
    }
}
