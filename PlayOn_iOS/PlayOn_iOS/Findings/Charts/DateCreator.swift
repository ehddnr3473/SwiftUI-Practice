//
//  DateCreator.swift
//  PlayOn_iOS
//
//  Created by 김동욱 on 2023/01/01.
//

import Foundation

struct DateCreator {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        
        return dateFormatter
    }()
    static func date(_ year: String) -> Date {
        dateFormatter.date(from: year)!
    }
}
