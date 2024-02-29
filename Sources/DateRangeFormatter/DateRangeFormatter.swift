// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public enum Components {
    case hoursAndMinutes
    case seconds
    case daysAndMonths
    case years
}

public struct DateRangeFormatter {
    public static func timeRange(start: String, end: String, timestampFormat: String, components: [Components]) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = timestampFormat
        guard let startDate = formatter.date(from: start) else {
            print("Invalid start timestamp") 
            return nil
        }
        guard let endDate = formatter.date(from: end) else {
            print("Invalid end timestamp")
            return nil
        }
        let calendar = Calendar.current
        let difference = calendar.dateComponents([.hour, .minute, .second, .day, .month, .year], from: startDate, to: endDate)
        var startStringComponents: [String] = []
        var endStringComponents: [String] = []
        
        if components.contains(.hoursAndMinutes) {
            var startTimeString: String = ""
            var endTimeString: String = ""
            
            
            startTimeString += getHoursAndMinutesString(startDate)
            if components.contains(.seconds) {
                startTimeString += getSecondsString(startDate)
            }
            if let hours = difference.hour,
               let minutes = difference.minute,
               hours > 0 || minutes > 0 {
                endTimeString += getHoursAndMinutesString(endDate)
                if components.contains(.seconds) {
                    endTimeString += getSecondsString(endDate)
                }
            }
            startStringComponents.append(startTimeString)
            endStringComponents.append(endTimeString)
        }
        
        if components.contains(.daysAndMonths) {
            endStringComponents.append(getDayString(endDate))
            if let days = difference.day,
               days > 0 {
                startStringComponents.append(getDayString(startDate))
            }
            endStringComponents.append(getMonthString(endDate))
            if let months = difference.month,
               let years = difference.year,
               months > 0 || years > 0 {
                startStringComponents.append(getMonthString(startDate))
            }
        }
        
        if components.contains(.years) {
            endStringComponents.append(getYearString(endDate))
            if let years = difference.year,
               years > 0 {
                startStringComponents.append(getYearString(startDate))
            }
        }
        
        return "\(startStringComponents.joined(separator: " ")) - \(endStringComponents.joined(separator: " "))"
    }
}

private func getHoursAndMinutesString(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "hh:mm"
    return formatter.string(from: date)
}

private func getSecondsString(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = ":ss"
    return formatter.string(from: date)
}

private func getDayString(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd."
    return formatter.string(from: date)
}

private func getMonthString(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM."
    return formatter.string(from: date)
}

private func getYearString(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    return formatter.string(from: date)
}
