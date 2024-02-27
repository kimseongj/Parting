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
    
    func makeMonthDate(date: Date) -> String {
        self.dateFormat = "MM월"
        return self.string(from: date)
    }
    
    func makeYearMonthDate(date: Date) -> String {
        self.dateFormat = "yyyy년 MM월"
        return self.string(from: date)
    }
    
    func makeDateFrom(stringDate: String) -> Date {
        self.dateFormat = "yyyy-MM-dd"
        let asd = self.date(from: stringDate)
        return self.date(from: stringDate) ?? Date()
    }
    
    func makeYearInt(date: Date) -> Int {
        self.dateFormat = "yyyy"
        let stringDate = self.string(from: date)
        let intDate = Int(stringDate) ?? 0
        
        return intDate
    }
    
    func makeMonthInt(date: Date) -> Int {
        self.dateFormat = "MM"
        let stringDate = self.string(from: date)
        let intDate = Int(stringDate) ?? 0
        
        return intDate
    }
    
    func makeIntToDate(year: Int, month: Int, day: Int) -> Date {
        self.dateFormat = "yyyy-MM"
        let stringYear = String(year)
        let stringDay = String(day)
        let date = stringYear + "-" + stringDay
        return self.date(from: date) ?? Date()
    }
}
