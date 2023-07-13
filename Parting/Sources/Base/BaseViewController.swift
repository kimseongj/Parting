//
//  BaseViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/04/25.
//

import UIKit

class BaseViewController<T: UIView>: UIViewController {
    public var rootView: T { return (view as? T)!}
    override open func loadView() {
        self.view = T()
    }
}
