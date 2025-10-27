//
//  TimeInterval+Extension.swift
//

import Foundation

extension TimeInterval {
    var asNanoseconds: TimeInterval {
        self * 1_000_000_000
    }

    public static var week: TimeInterval {
        day * 7
    }
    
    public static var day: TimeInterval {
        hour * 24
    }
    
    public static var hour: TimeInterval {
        minute * 60
    }
    
    public static var minute: TimeInterval {
        60
    }
}
