# Date range formatter SwiftUI package
## Usage:
Provides functionality to format date ranges with various components such as hours, minutes, seconds, days, months, and years. Eliminates redundant occurences of identical components.
## Components:
`hoursAndMinutes`: Includes hours and minutes in the formatted output.<br>
`seconds`: Includes seconds in the formatted output.<br>
`daysAndMonths`: Includes days and months in the formatted output.<br>
`years`: Includes years in the formatted output.<br>
## Inputs:
`start`: Timestamp for the start of the time range in a string format.<br>
`end`: Timestamp for the end of the time range in a string format.<br>
`timestampFormat`: The format for start and end timestamps defined by a string, which is fed to `DateFormatter()`, so it need to have the correct format. For example `"yyyy-MM-dd HH:mm:ss"`.<br>
`components`: Date and time components that will be displayed in the returned string. It is an array with all desired components from:<br>
- Hours and minutes<br>
- *Seconds (only extends hours and minutes, won’t be displayed without it)*<br>
- Days and months<br>
- Years<br>
## Output:
Returns an optional string, so the result has to be unwrapped before used.
## Example:
```
if let dateRange = DateRangeFormatter.timeRange(
    start: "2024-04-17 19:00:00",
    end: "2024-05-18 20:00:00",
    timestampFormat: "yyyy-MM-dd HH:mm:ss",
    components: [.hoursAndMinutes,.daysAndMonths,.years]
) {
    print(dateRange)
}
```
returns `"19:00 17. 04. - 20:00 18. 05. 2024"`

```
if let dateRange = DateRangeFormatter.timeRange(
    start: "2024-04-17 19:00:00",
    end: "2024-05-18 20:00:00",
    timestampFormat: "yyyy-MM-dd HH:mm:ss",
    components: [.daysAndMonths,.years]
) {
    print(dateRange)
}
```
returns `"17. 04. - 18. 05. 2024"`
```
if let dateRange = DateRangeFormatter.timeRange(
    start: "2024-04-17 19:00:00",
    end: "2024-05-18 20:00:00",
    timestampFormat: "yyyy-MM-dd HH:mm:ss",
    components: [.hoursAndMinutes]
) {
    print(dateRange)
}
```
returns `"19:00 - 20:00"`
