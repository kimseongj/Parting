//
//  DetailCategoryCollectionViewCell.swift
//  Parting
//
//  Created by 박시현 on 2023/07/24.
//

import UIKit
import SnapKit

class DetailCategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "DetailCategoryCollectionViewCell"
    
    let detailCellTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    
    //MARK: - cell의 텍스트에 따라서 configure
    func configureCell(text: String) {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.addSubview(detailCellTitle)
    }
    
    func constraints() {
        detailCellTitle.snp.makeConstraints { make in
            
        }
    }
    
    
}
