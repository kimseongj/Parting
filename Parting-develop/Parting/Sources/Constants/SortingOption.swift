//
//  SortingOption.swift
//  Parting
//
//  Created by 박시현 on 2023/08/17.
//

import Foundation

enum SortingOption {
    
    case numberOfPeople(NumberOfPeopleType)
    case time(TimeType)
    
    var displayName: String {
        switch self {
        case .numberOfPeople(let peopleNumOption):
            switch peopleNumOption {
            case .few:
                return "인원 적은 순"
            case .many:
                return "인원 많은 순"
            default:
                return "인원 순"
            }
        case .time(let timeOption):
            switch timeOption {
            case .latest:
                return "최근 개설 순"
            case .closingTime:
                return "마감 시간 순"
            default:
                return "거리 순"
            }
        }
    }
    
    var index: Int {
        switch self {
        case .numberOfPeople(let peopleNumOption):
            switch peopleNumOption {
            case .few:
                return 2
            case .many:
                return 1
            case .none:
                return 0
            }
        case .time(let timeOption):
            switch timeOption {
            case .latest:
                return 2
            case .closingTime:
                return 1
            case .closest:
                return 0
            case .none:
                return 0
            }
        }
    }
    
    enum NumberOfPeopleType: String {
        case few = "FEW_PEOPLE"
        case many = "MANY_PEOPLE"
        case none = "NONE"
    }
    
    enum TimeType: String {
        case latest = "LATEST"
        case closingTime = "CLOSING_TIME"
        case closest = "CLOSING_DISTANCE"
        case none = "NONE"
    }
    
}
