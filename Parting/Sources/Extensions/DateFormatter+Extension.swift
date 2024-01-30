//
//  DateFormatter.swift
//  Parting
//
//  Created by kimseongjun on 1/29/24.
//

import Foundation

extension DateFormatter {
    func makeNowMonthDate() -> String {
        self.dateFormat = "MM월"
        self.locale = Locale(identifier: "ko_KR")
        self.timeZone = TimeZone(identifier: "KST")
        return self.string(from: Date())
    }
    
    func makeYearMonthDate(date: Date) -> String {
        self.dateFormat = "yyyy년 MM월"
        return self.string(from: date)
    }
}
