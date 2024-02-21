//
//  MutableSizeTableView.swift
//  Parting
//
//  Created by kimseongjun on 2/13/24.
//

import UIKit

final class MutableSizeTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            if oldValue.height != self.contentSize.height {
                invalidateIntrinsicContentSize()
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
