import Testing
import Foundation
@testable import CoffeeKit

@Suite("Uptime Formatter Tests")
struct UptimeFormatterTests {
    
    @Test("Format zero seconds")
    func testFormatZeroSeconds() async throws {
        let uptime = UptimeFormatter.formattedUptime(from: 0)
        
        // Should format as a valid time string
        #expect(!uptime.isEmpty)
        #expect(uptime.contains("00") || uptime.contains("0"))
        #expect(uptime.contains(":"))
    }
    
    @Test("Format seconds only")
    func testFormatSecondsOnly() async throws {
        let uptime = UptimeFormatter.formattedUptime(from: 45)
        
        // Should show 00:00:45 or similar
        #expect(uptime.contains("45"))
        #expect(!uptime.contains("46"))
    }
    
    @Test("Format one minute")
    func testFormatOneMinute() async throws {
        let uptime = UptimeFormatter.formattedUptime(from: 60)
        
        // Should show 00:01:00 or similar
        #expect(uptime.contains("01"))
        #expect(uptime.contains("00"))
    }
    
    @Test("Format minutes and seconds")
    func testFormatMinutesAndSeconds() async throws {
        let uptime = UptimeFormatter.formattedUptime(from: 125) // 2 minutes, 5 seconds
        
        #expect(uptime.contains("02") || uptime.contains("2"))
        #expect(uptime.contains("05") || uptime.contains("5"))
    }
    
    @Test("Format one hour")
    func testFormatOneHour() async throws {
        let uptime = UptimeFormatter.formattedUptime(from: 3600)
        
        // Should show 01:00:00 or similar
        #expect(uptime.contains("01:00:00") || uptime.contains("1:00:00"))
    }
    
    @Test("Format hours, minutes, and seconds")
    func testFormatHoursMinutesSeconds() async throws {
        let uptime = UptimeFormatter.formattedUptime(from: 3665) // 1 hour, 1 minute, 5 seconds
        
        #expect(uptime.contains("01") || uptime.contains("1"))
        #expect(uptime.contains("05") || uptime.contains("5"))
    }
    
    @Test("Format one day")
    func testFormatOneDay() async throws {
        let uptime = UptimeFormatter.formattedUptime(from: 86400) // 1 day
        
        // Should show 1:00:00:00 or similar
        #expect(uptime.contains("1"))
        #expect(uptime.contains("00:00:00"))
    }
    
    @Test("Format days, hours, minutes, and seconds")
    func testFormatFullUptime() async throws {
        let uptime = UptimeFormatter.formattedUptime(from: 90061) // 1 day, 1 hour, 1 minute, 1 second
        
        // Should show 1:01:01:01 format
        #expect(uptime.contains("1"))
        #expect(uptime.contains("01") || uptime.contains("1"))
    }
    
    @Test("Format multiple days")
    func testFormatMultipleDays() async throws {
        let uptime = UptimeFormatter.formattedUptime(from: 259200) // 3 days
        
        #expect(uptime.contains("3"))
        #expect(uptime.contains("00:00:00"))
    }
    
    @Test("Format large uptime")
    func testFormatLargeUptime() async throws {
        let uptime = UptimeFormatter.formattedUptime(from: 999999) // ~11.5 days
        
        #expect(!uptime.isEmpty)
        #expect(uptime.contains(":"))
    }
    
    @Test("Format very large uptime")
    func testFormatVeryLargeUptime() async throws {
        let uptime = UptimeFormatter.formattedUptime(from: 31536000) // 365 days
        
        #expect(!uptime.isEmpty)
        #expect(uptime.contains("365"))
    }
    
    @Test("Format with padding")
    func testFormatWithPadding() async throws {
        let uptime = UptimeFormatter.formattedUptime(from: 3661) // 1:01:01
        
        // Minutes and seconds should be zero-padded
        #expect(uptime.contains("01:01") || uptime.contains("1:01"))
    }
    
    @Test("Format boundary value at 24 hours")
    func testFormatBoundaryAt24Hours() async throws {
        let uptime = UptimeFormatter.formattedUptime(from: 86399) // 23:59:59
        
        #expect(uptime.contains("23:59:59"))
    }
    
    @Test("Format exactly one day transition")
    func testFormatExactlyOneDayTransition() async throws {
        let almostOneDay = UptimeFormatter.formattedUptime(from: 86399) // 23:59:59
        let exactlyOneDay = UptimeFormatter.formattedUptime(from: 86400) // 1:00:00:00
        
        #expect(almostOneDay != exactlyOneDay)
        #expect(exactlyOneDay.contains("1"))
    }
    
    @Test("Format negative value")
    func testFormatNegativeValue() async throws {
        let uptime = UptimeFormatter.formattedUptime(from: -100)
        
        // Should handle gracefully, likely treating as 0 or showing negative
        #expect(!uptime.isEmpty)
    }
    
    @Test("Format fractional seconds")
    func testFormatFractionalSeconds() async throws {
        let uptime = UptimeFormatter.formattedUptime(from: 90.7) // 1 minute, 30.7 seconds
        
        // Should truncate or round to 1:30
        #expect(uptime.contains("01:30") || uptime.contains("1:30"))
    }
    
    @Test("Format consistency")
    func testFormatConsistency() async throws {
        let seconds: TimeInterval = 12345
        
        let uptime1 = UptimeFormatter.formattedUptime(from: seconds)
        let uptime2 = UptimeFormatter.formattedUptime(from: seconds)
        
        // Same input should produce same output
        #expect(uptime1 == uptime2)
    }
}
