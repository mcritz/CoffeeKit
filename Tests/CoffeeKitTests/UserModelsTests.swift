import Testing
import Foundation
@testable import CoffeeKit

@Suite("User Models Tests")
struct UserModelsTests {
    
    // MARK: - UserCreate Tests
    
    @Test("UserCreate initialization")
    func testUserCreateInitialization() async throws {
        let user = UserCreate(
            name: "John Doe",
            email: "john@example.com",
            password: "securePassword123",
            confirmPassword: "securePassword123"
        )
        
        #expect(user.name == "John Doe")
        #expect(user.email == "john@example.com")
        #expect(user.password == "securePassword123")
        #expect(user.confirmPassword == "securePassword123")
    }
    
    @Test("UserCreate is Codable")
    func testUserCreateCodable() async throws {
        let user = UserCreate(
            name: "Jane Smith",
            email: "jane@example.com",
            password: "password456",
            confirmPassword: "password456"
        )
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let data = try encoder.encode(user)
        let decoded = try decoder.decode(UserCreate.self, from: data)
        
        #expect(decoded.name == user.name)
        #expect(decoded.email == user.email)
        #expect(decoded.password == user.password)
        #expect(decoded.confirmPassword == user.confirmPassword)
    }
    
    @Test("UserCreate with empty strings")
    func testUserCreateWithEmptyStrings() async throws {
        let user = UserCreate(
            name: "",
            email: "",
            password: "",
            confirmPassword: ""
        )
        
        #expect(user.name == "")
        #expect(user.email == "")
        #expect(user.password == "")
        #expect(user.confirmPassword == "")
    }
    
    @Test("UserCreate is Sendable")
    func testUserCreateSendable() async throws {
        let user = UserCreate(
            name: "Test User",
            email: "test@example.com",
            password: "pass123",
            confirmPassword: "pass123"
        )
        
        // Should compile without warnings because UserCreate conforms to Sendable
        Task {
            let _ = user
        }
    }
    
    @Test("UserCreate JSON serialization format")
    func testUserCreateJSONFormat() async throws {
        let user = UserCreate(
            name: "Test",
            email: "test@test.com",
            password: "pass",
            confirmPassword: "pass"
        )
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(user)
        let json = String(data: data, encoding: .utf8)!
        
        #expect(json.contains("name"))
        #expect(json.contains("email"))
        #expect(json.contains("password"))
        #expect(json.contains("confirmPassword"))
    }
    
    // MARK: - UserPrivate Tests
    
    @Test("UserPrivate initialization with ID")
    func testUserPrivateInitializationWithID() async throws {
        let id = UUID()
        let user = UserPrivate(
            id: id,
            name: "John Doe",
            email: "john@example.com"
        )
        
        #expect(user.id == id)
        #expect(user.name == "John Doe")
        #expect(user.email == "john@example.com")
    }
    
    @Test("UserPrivate initialization without ID")
    func testUserPrivateInitializationWithoutID() async throws {
        let user = UserPrivate(
            id: nil,
            name: "Jane Smith",
            email: "jane@example.com"
        )
        
        #expect(user.id == nil)
        #expect(user.name == "Jane Smith")
        #expect(user.email == "jane@example.com")
    }
    
    @Test("UserPrivate default ID is nil")
    func testUserPrivateDefaultID() async throws {
        let user = UserPrivate(
            name: "Test User",
            email: "test@example.com"
        )
        
        #expect(user.id == nil)
    }
    
    @Test("UserPrivate is Codable")
    func testUserPrivateCodable() async throws {
        let id = UUID()
        let user = UserPrivate(
            id: id,
            name: "John Doe",
            email: "john@example.com"
        )
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let data = try encoder.encode(user)
        let decoded = try decoder.decode(UserPrivate.self, from: data)
        
        #expect(decoded.id == user.id)
        #expect(decoded.name == user.name)
        #expect(decoded.email == user.email)
    }
    
    @Test("UserPrivate is Sendable")
    func testUserPrivateSendable() async throws {
        let user = UserPrivate(
            id: UUID(),
            name: "Test",
            email: "test@example.com"
        )
        
        // Should compile without warnings because UserPrivate conforms to Sendable
        Task {
            let _ = user
        }
    }
    
    @Test("UserPrivate with special characters in email")
    func testUserPrivateWithSpecialCharactersInEmail() async throws {
        let user = UserPrivate(
            name: "Test User",
            email: "test+tag@example.co.uk"
        )
        
        #expect(user.email == "test+tag@example.co.uk")
    }
    
    // MARK: - UserPublic Tests
    
    @Test("UserPublic initialization with ID")
    func testUserPublicInitializationWithID() async throws {
        let id = UUID()
        let user = UserPublic(
            id: id,
            name: "John Doe"
        )
        
        #expect(user.id == id)
        #expect(user.name == "John Doe")
    }
    
    @Test("UserPublic initialization without ID")
    func testUserPublicInitializationWithoutID() async throws {
        let user = UserPublic(
            id: nil,
            name: "Jane Smith"
        )
        
        #expect(user.id == nil)
        #expect(user.name == "Jane Smith")
    }
    
    @Test("UserPublic default ID is nil")
    func testUserPublicDefaultID() async throws {
        let user = UserPublic(name: "Test User")
        
        #expect(user.id == nil)
        #expect(user.name == "Test User")
    }
    
    @Test("UserPublic is Codable")
    func testUserPublicCodable() async throws {
        let id = UUID()
        let user = UserPublic(
            id: id,
            name: "John Doe"
        )
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let data = try encoder.encode(user)
        let decoded = try decoder.decode(UserPublic.self, from: data)
        
        #expect(decoded.id == user.id)
        #expect(decoded.name == user.name)
    }
    
    @Test("UserPublic is Sendable")
    func testUserPublicSendable() async throws {
        let user = UserPublic(
            id: UUID(),
            name: "Test User"
        )
        
        // Should compile without warnings because UserPublic conforms to Sendable
        Task {
            let _ = user
        }
    }
    
    @Test("UserPublic with empty name")
    func testUserPublicWithEmptyName() async throws {
        let user = UserPublic(name: "")
        
        #expect(user.name == "")
    }
    
    @Test("UserPublic JSON does not contain email")
    func testUserPublicJSONFormat() async throws {
        let user = UserPublic(
            id: UUID(),
            name: "Test User"
        )
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(user)
        let json = String(data: data, encoding: .utf8)!
        
        #expect(json.contains("name"))
        #expect(json.contains("id"))
        #expect(!json.contains("email")) // Should not contain email
        #expect(!json.contains("password")) // Should not contain password
    }
    
    // MARK: - Comparison Tests
    
    @Test("Different user models have different data")
    func testUserModelsDifferentData() async throws {
        let id = UUID()
        let name = "John Doe"
        let email = "john@example.com"
        
        let userPublic = UserPublic(id: id, name: name)
        let userPrivate = UserPrivate(id: id, name: name, email: email)
        
        // UserPublic has no email field
        #expect(userPublic.name == name)
        #expect(userPublic.id == id)
        
        // UserPrivate has email field
        #expect(userPrivate.name == name)
        #expect(userPrivate.id == id)
        #expect(userPrivate.email == email)
    }
    
    @Test("UserCreate and UserPrivate have different purposes")
    func testUserCreateVsUserPrivate() async throws {
        let userCreate = UserCreate(
            name: "John Doe",
            email: "john@example.com",
            password: "pass123",
            confirmPassword: "pass123"
        )
        
        let userPrivate = UserPrivate(
            id: UUID(),
            name: "John Doe",
            email: "john@example.com"
        )
        
        // UserCreate has password fields
        #expect(userCreate.password == "pass123")
        #expect(userCreate.confirmPassword == "pass123")
        
        // UserPrivate has ID but no password fields
        #expect(userPrivate.id != nil)
    }
    
    @Test("All user models encode and decode correctly")
    func testAllUserModelsCodable() async throws {
        let id = UUID()
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        // UserCreate
        let userCreate = UserCreate(name: "Test", email: "test@test.com", password: "pass", confirmPassword: "pass")
        let createData = try encoder.encode(userCreate)
        let decodedCreate = try decoder.decode(UserCreate.self, from: createData)
        #expect(decodedCreate.name == userCreate.name)
        
        // UserPrivate
        let userPrivate = UserPrivate(id: id, name: "Test", email: "test@test.com")
        let privateData = try encoder.encode(userPrivate)
        let decodedPrivate = try decoder.decode(UserPrivate.self, from: privateData)
        #expect(decodedPrivate.id == userPrivate.id)
        
        // UserPublic
        let userPublic = UserPublic(id: id, name: "Test")
        let publicData = try encoder.encode(userPublic)
        let decodedPublic = try decoder.decode(UserPublic.self, from: publicData)
        #expect(decodedPublic.id == userPublic.id)
    }
}
