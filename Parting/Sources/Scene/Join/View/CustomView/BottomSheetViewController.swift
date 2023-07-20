//
//  BottomSheetViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/07/19.
//

import UIKit

class BottomSheetViewController: BaseViewController<BottomSheetView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.medium(), .large()]
            sheetPresentationController.largestUndimmedDetentIdentifier = .medium
            sheetPresentationController.preferredCornerRadius = 50
            sheetPresentationController.prefersGrabberVisible = true
            sheetPresentationController.delegate = self
        }
    }
    
}

extension BottomSheetViewController: UISheetPresentationControllerDelegate {
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        print("sheet의 detent 변경!")
        print(sheetPresentationController.selectedDetentIdentifier)
    }
}
