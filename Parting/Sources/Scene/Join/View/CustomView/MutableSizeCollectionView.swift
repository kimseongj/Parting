//
//  File.swift
//  Parting
//
//  Created by kimseongjun on 1/16/24.
//

import UIKit

final class MutableSizeCollectionView: UICollectionView {
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
