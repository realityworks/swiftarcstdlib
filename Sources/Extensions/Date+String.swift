//
//  Date+String.swift
//

import Foundation

public extension Date {
    init?(simpleDateFormatString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        guard let date = dateFormatter.date(from: simpleDateFormatString) else {
            return nil
        }

        self = date
    }

    var simpleDateFormatString: String {
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"

        return df.string(from: self)
    }

    var simpleTimeFormatString: String {
        let df = DateFormatter()
        df.dateFormat = "hh:mm a"

        return df.string(from: self)
    }

    var completeDataFormatString: String {
        let df = DateFormatter()
        df.dateFormat = "y-MM-dd H:mm:ss.SSS"

        return df.string(from: self)
    }
}
