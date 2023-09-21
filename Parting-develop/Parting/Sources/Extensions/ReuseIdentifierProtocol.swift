//
//  ReuseIdentifierProtocol.swift
//  Parting
//
//  Created by 박시현 on 2023/08/11.
//

import UIKit

protocol ReuseIdentifierProtocol {
    static var identifier: String { get }
}

extension UICollectionViewCell: ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
    
    
}

extension UITableViewCell: ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
    
    
}


extension UITableViewHeaderFooterView: ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
