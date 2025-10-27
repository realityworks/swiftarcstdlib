//
//  TimeInterval+Extension.swift
//

import Foundation

extension TimeInterval {
    var asNanoseconds: TimeInterval {
        self * 1_000_000_000
    }

    static var week: TimeInterval {
        day * 7
    }
    
    static var day: TimeInterval {
        hour * 24
    }
    
    static var hour: TimeInterval {
        minute * 60
    }
    
    static var minute: TimeInterval {
        60
    }
}
