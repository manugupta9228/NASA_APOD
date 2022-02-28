//
//  Utility.swift
//  NASA APOD
//
//  Created by manu.a.gupta on 28/02/22.
//

import Foundation

class Utility {
    
    static func getTodayStringDate() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        return dateformatter.string(from: Date())
    }
    
    static func convertDateToYYYYDDMMFormat(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        if let dateFromString = dateFormatter.date(from: dateString) {
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "yyyy-MM-dd"
            return dateFormatter2.string(from: dateFromString)
        }
        return nil
    }
    
    static func convertDateToMMMDDYYFormat(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let dateFromString = dateFormatter.date(from: dateString) {
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "MMM dd, yyyy"
            return dateFormatter2.string(from: dateFromString)
        }
        return nil
    }
}
