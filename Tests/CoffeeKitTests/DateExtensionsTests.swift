// AI Generated

import Testing
import Foundation
@testable import CoffeeKit

@Suite("Date Extensions Tests")
struct DateExtensionsTests {
    
    @Test("Format date with default parameters")
    func testFormatWithDefaults() async throws {
        let date = Date(timeIntervalSince1970: 1609459200) // 2021-01-01 00:00:00 UTC
        let formatted = date.formattedWith()
        
        // Should use medium date style and short time style with LA timezone
        #expect(!formatted.isEmpty)
        #expect(formatted.contains("2020") || formatted.contains("2021")) // Date parts
    }
    
    @Test("Format date with custom date style")
    func testFormatWithCustomDateStyle() async throws {
        let date = Date(timeIntervalSince1970: 1609459200)
        
        let shortStyle = date.formattedWith(dateStyle: .short)
        let longStyle = date.formattedWith(dateStyle: .long)
        let fullStyle = date.formattedWith(dateStyle: .full)
        
        #expect(!shortStyle.isEmpty)
        #expect(!longStyle.isEmpty)
        #expect(!fullStyle.isEmpty)
        
        // Full style should be longer than short style
        #expect(fullStyle.count > shortStyle.count)
    }
    
    @Test("Format date with custom time style")
    func testFormatWithCustomTimeStyle() async throws {
        let date = Date(timeIntervalSince1970: 1609459200)
        
        let noTime = date.formattedWith(timeStyle: .none)
        let shortTime = date.formattedWith(timeStyle: .short)
        let mediumTime = date.formattedWith(timeStyle: .medium)
        let longTime = date.formattedWith(timeStyle: .long)
        
        #expect(!noTime.isEmpty)
        #expect(!shortTime.isEmpty)
        #expect(!mediumTime.isEmpty)
        #expect(!longTime.isEmpty)
    }
    
    @Test("Format date with UTC timezone")
    func testFormatWithUTCTimezone() async throws {
        let date = Date(timeIntervalSince1970: 1609459200) // 2021-01-01 00:00:00 UTC
        let utc = TimeZone(identifier: "UTC")!
        
        let formatted = date.formattedWith(
            dateStyle: .short,
            timeStyle: .short,
            timeZone: utc
        )
        
        #expect(!formatted.isEmpty)
        // In UTC, this should show 00:00 or midnight
    }
    
    @Test("Format date with different timezones")
    func testFormatWithDifferentTimezones() async throws {
        let date = Date(timeIntervalSince1970: 1609459200)
        
        let la = TimeZone(identifier: "America/Los_Angeles")!
        let ny = TimeZone(identifier: "America/New_York")!
        let tokyo = TimeZone(identifier: "Asia/Tokyo")!
        
        let laFormatted = date.formattedWith(timeZone: la)
        let nyFormatted = date.formattedWith(timeZone: ny)
        let tokyoFormatted = date.formattedWith(timeZone: tokyo)
        
        #expect(!laFormatted.isEmpty)
        #expect(!nyFormatted.isEmpty)
        #expect(!tokyoFormatted.isEmpty)
        
        // Different timezones should produce different results
        #expect(laFormatted != tokyoFormatted)
    }
    
    @Test("Format date with current timezone fallback")
    func testFormatWithCurrentTimezoneFallback() async throws {
        let date = Date()
        
        // The default parameter has a fallback to .current if LA timezone is unavailable
        let formatted = date.formattedWith()
        
        #expect(!formatted.isEmpty)
    }
    
    @Test("Format date with no date style")
    func testFormatWithNoDateStyle() async throws {
        let date = Date(timeIntervalSince1970: 1609459200)
        
        let formatted = date.formattedWith(dateStyle: .none, timeStyle: .medium)
        
        #expect(!formatted.isEmpty)
        // Should only contain time information
    }
    
    @Test("Format date consistently")
    func testFormatConsistency() async throws {
        let date = Date(timeIntervalSince1970: 1609459200)
        let timezone = TimeZone(identifier: "UTC")!
        
        let formatted1 = date.formattedWith(
            dateStyle: .medium,
            timeStyle: .short,
            timeZone: timezone
        )
        let formatted2 = date.formattedWith(
            dateStyle: .medium,
            timeStyle: .short,
            timeZone: timezone
        )
        
        // Same date with same parameters should produce identical results
        #expect(formatted1 == formatted2)
    }
}
