// AI Generated

import Testing
import Foundation
@testable import CoffeeKit

@Suite("Location Equatable Tests")
struct LocationEquatableTests {
  
  @Test("Equality by applePlaceID: same applePlaceID, different other fields should be equal")
  func testEqualityByApplePlaceID() {
    let loc1 = Location(address: "123 A St", latitude: 37.77, longitude: -122.41, applePlaceID: "abc123")
    let loc2 = Location(address: "456 B Ave", latitude: 38.88, longitude: -121.39, applePlaceID: "abc123")
    #expect(loc1 == loc2)
  }
  
  @Test("Equality by address: same address, different other fields should be equal")
  func testEqualityByAddress() {
    let loc1 = Location(address: "789 C Blvd", latitude: 40.71, longitude: -74.01, applePlaceID: "id1")
    let loc2 = Location(address: "789 C Blvd", latitude: 35.67, longitude: -120.45, applePlaceID: "id2")
    #expect(loc1 == loc2)
  }
  
  @Test("Equality by coordinates: identical latitude and longitude should be equal even if other fields differ")
  func testEqualityByCoordinates() {
    let loc1 = Location(address: "Addr1", latitude: 51.50, longitude: -0.12, applePlaceID: "place1")
    let loc2 = Location(address: "Addr2", latitude: 51.50, longitude: -0.12, applePlaceID: "place2")
    #expect(loc1 == loc2)
  }
  
  @Test("Inequality when nothing matches: different placeID, address, and coordinates not both matching")
  func testInequalityWhenNothingMatches() {
    let loc1 = Location(address: "AddrA", latitude: 10.0, longitude: 20.0, applePlaceID: "idA")
    let loc2 = Location(address: "AddrB", latitude: 30.0, longitude: 40.0, applePlaceID: "idB")
    #expect(loc1 != loc2)
  }

  @Test("Partial coordinate mismatch: same latitude but different longitude should not be equal")
  func testPartialCoordinateMismatchLatitudeSame() {
    let loc1 = Location(address: nil, latitude: 15.0, longitude: 25.0, applePlaceID: nil)
    let loc2 = Location(address: nil, latitude: 15.0, longitude: 26.0, applePlaceID: nil)
    #expect(loc1 != loc2)
  }
  
  @Test("Partial coordinate mismatch: same longitude but different latitude should not be equal")
  func testPartialCoordinateMismatchLongitudeSame() {
    let loc1 = Location(address: nil, latitude: 15.0, longitude: 25.0, applePlaceID: nil)
    let loc2 = Location(address: nil, latitude: 16.0, longitude: 25.0, applePlaceID: nil)
    #expect(loc1 != loc2)
  }
  
  @Test("All nil fields vs all nil fields should be equal")
  func testAllNilFieldsEqual() {
    let loc1 = Location(address: nil, latitude: nil, longitude: nil, applePlaceID: nil)
    let loc2 = Location(address: nil, latitude: nil, longitude: nil, applePlaceID: nil)
    #expect(loc1 == loc2)
  }
  
  @Test("Mixed nil/non-nil fields where no rule triggers should be not equal")
  func testMixedNilNonNilFieldsNotEqual() {
    let loc1 = Location(address: "Addr", latitude: nil, longitude: nil, applePlaceID: nil)
    let loc2 = Location(address: nil, latitude: 10.0, longitude: 20.0, applePlaceID: nil)
    #expect(loc1 != loc2)
  }
  
  @Test("Preference doesn't matter: multiple matching fields still equal")
  func testMultipleMatchesStillEqual() {
    let loc1 = Location(address: "SameAddr", latitude: 10.0, longitude: 20.0, applePlaceID: "sameID")
    let loc2 = Location(address: "SameAddr", latitude: 10.0, longitude: 20.0, applePlaceID: "sameID")
    #expect(loc1 == loc2)
  }
  
  @Test("Floating point exact match equal, very close but not exact not equal")
  func testFloatingPointCoordinatesEquality() {
    let locExact1 = Location(address: nil, latitude: 12.3456789, longitude: 98.7654321, applePlaceID: nil)
    let locExact2 = Location(address: nil, latitude: 12.3456789, longitude: 98.7654321, applePlaceID: nil)
    let locClose = Location(address: nil, latitude: 12.3456788, longitude: 98.7654320, applePlaceID: nil)
    #expect(locExact1 == locExact2)
    #expect(locExact1 != locClose)
  }

  @Test("Ensure commutativity: a == b implies b == a")
  func testEqualityIsCommutative() {
    let a = Location(address: "Addr", latitude: 1.0, longitude: 2.0, applePlaceID: "pid")
    let b = Location(address: "Addr", latitude: 1.0, longitude: 2.0, applePlaceID: "pid")
    #expect(a == b)
    #expect(b == a)
  }
}
