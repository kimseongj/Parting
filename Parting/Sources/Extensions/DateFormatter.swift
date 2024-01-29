//
//  DateFormatter.swift
//  Parting
//
//  Created by kimseongjun on 1/29/24.
//

import Foundation

extension DateFormatter {
    func makeMonthFormatter() {
        self.dateFormat = "MM월"
        self.locale = Locale(identifier: "ko_KR")
        self.timeZone = TimeZone(identifier: "KST")
    }
}
