//
//  TimeFormattor.swift
//  CheckEat-Business
//
//  Created by 최준영 on 7/17/25.
//

import Foundation

public let hourMinuteFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "HH:mm"
    return formatter
}()

public let ampmFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "a"
    return formatter
}()

public func ampmString(from date: Date) -> String {
    return ampmFormatter.string(from: date)
}

public func hourMinuteString(from date: Date) -> String {
    return hourMinuteFormatter.string(from: date)
}
