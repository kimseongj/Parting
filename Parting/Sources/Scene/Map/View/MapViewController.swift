//
//  MapViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/07/14.
//

import UIKit

class MapViewController: BaseViewController<MapView> {

    private let viewModel: MapViewModel
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
       
    }
    
    private func navigationUI() {
        navigationController?.isNavigationBarHidden = false
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: )
    }
 
}
