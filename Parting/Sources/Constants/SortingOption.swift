//
//  SortingOption.swift
//  Parting
//
//  Created by 박시현 on 2023/08/17.
//

import Foundation

enum SortingOption {
    case none
    case closingTime
    case closingDistance
    case latest
    case manyPeople
    case fewPeople
    
    var description: String {
        switch self {
        case .none:
            return "기본순"
        case .closingDistance:
            return "가까운 순"
        case .closingTime:
            return "마감 시간 순"
        case .latest:
            return "최근 개설 순"
        case .manyPeople:
            return "인원 많은 순"
        case .fewPeople:
            return "인원 적은 순"
        }
    }
    
    var queryDescription: String {
        switch self {
        case .none:
            return "NONE"
        case .closingDistance:
            return "CLOSING_DISTANCE"
        case .closingTime:
            return "CLOSING_TIME"
        case .latest:
            return "LATEST"
        case .manyPeople:
            return "MANY_PEOPLE"
        case .fewPeople:
            return "FEW_PEOPLE"
        }
    }
}
