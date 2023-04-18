//
//  BaseViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/04/17.
//

import Foundation

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}

