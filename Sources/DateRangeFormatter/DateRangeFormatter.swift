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
        
        // MARK: - Hours, minutes, seconds
        if components.contains(.hoursAndMinutes) {
            var startTimeString: String = ""
            var endTimeString: String = ""
            
            startTimeString += getHoursAndMinutesString(startDate)
            if components.contains(.seconds) {
                startTimeString += getSecondsString(startDate)
            }
            if getHoursAndMinutesString(endDate) != getHoursAndMinutesString(startDate) {
                endTimeString += getHoursAndMinutesString(endDate)
                if components.contains(.seconds) {
                    endTimeString += getSecondsString(endDate)
                }
            }
            startStringComponents.append(startTimeString)
            endStringComponents.append(endTimeString)
        }
        
        // MARK: - Days, months
        if components.contains(.daysAndMonths) {
            endStringComponents.append(getDayString(endDate))
            if getDayString(startDate) != getDayString(endDate) {
                startStringComponents.append(getDayString(startDate))
            }
            endStringComponents.append(getMonthString(endDate))
            if getYearString(startDate) != getYearString(endDate) || getMonthString(startDate) != getMonthString(endDate) {
                startStringComponents.append(getMonthString(startDate))
            }
        }
        
        // MARK: - Years
        if components.contains(.years) {
            endStringComponents.append(getYearString(endDate))
            if getYearString(startDate) != getYearString(endDate) {
                startStringComponents.append(getYearString(startDate))

            }
        }
        
        return "\(startStringComponents.joined(separator: " ")) - \(endStringComponents.joined(separator: " "))"
    }
}

private func getHoursAndMinutesString(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
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
