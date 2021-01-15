//
//  PropertyWrappersTests.swift
//  TYUtils_Tests
//
//  Created by Olivier Voyer on 08/01/2021.
//  Copyright © 2021 TekITEazy. All rights reserved.
//

import XCTest
@testable import TYUtils

import KeychainSwift

let defaultStringValue: String = "Default"
let newStringValue: String = "New"
let defaultBoolValue: Bool = true
let newBoolValue: Bool = !defaultBoolValue
let defaultDataValue: Data! = "Default".data(using: .utf8)
let newDataValue: Data! = "New".data(using: .utf8)

class TYUtilsPropertyWrappersTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        UserDefaults.standard.reset()
        KeychainSwift().reset()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        UserDefaults.standard.reset()
        KeychainSwift().reset()
    }

    @UserDefault(key: .testUserDefaultStringKey)
    var userDefaultString: String = defaultStringValue

    @UserDefault(key: .testUserDefaultBoolKey)
    var userDefaultBool: Bool = defaultBoolValue

    @UserDefault(key: .testUserDefaultDataKey)
    var userDefaultData: Data = defaultDataValue

    func testUserDefault() throws {
        _testUserDefaultString()
        _testUserDefaultBool()
        _testUserDefaultData()
    }

    @OptionalUserDefault(key: .testOptionalUserDefaultStringKey)
    var optionalUserDefaultString: String?

    @OptionalUserDefault(key: .testOptionalUserDefaultBoolKey)
    var optionalUserDefaultBool: Bool?

    @OptionalUserDefault(key: .testOptionalUserDefaultDataKey)
    var optionalUserDefaultData: Data?

    func testOptionalUserDefault() throws {
        _testOptionalUserDefaultString()
        _testOptionalUserDefaultBool()
        _testOptionalUserDefaultData()
    }

    @Keychain(key: .testKeychainStringKey)
    var keychainString: String = defaultStringValue

    @Keychain(key: .testKeychainBoolKey)
    var keychainBool: Bool = defaultBoolValue

    @Keychain(key: .testKeychainDataKey)
    var keychainData: Data = defaultDataValue

    func testKeychain() throws {
        _testKeychainString()
        _testKeychainBool()
        _testKeychainData()
    }

    private func _testUserDefaultString() {
        // Default value
        XCTAssertEqual(userDefaultString, defaultStringValue)

        // Updated value
        userDefaultString = newStringValue
        XCTAssertEqual(userDefaultString, newStringValue)

        // Default value again
        UserDefaults.standard.reset()
        XCTAssertEqual(userDefaultString, defaultStringValue)
    }

    private func _testUserDefaultBool() {
        // Default value
        XCTAssertEqual(userDefaultBool, defaultBoolValue)

        // Updated value
        userDefaultBool = newBoolValue
        XCTAssertEqual(userDefaultBool, newBoolValue)

        // Default value again
        UserDefaults.standard.reset()
        XCTAssertEqual(userDefaultBool, defaultBoolValue)
    }

    private func _testUserDefaultData() {
        // Default value
        XCTAssertEqual(userDefaultData, defaultDataValue)

        // Updated value
        userDefaultData = newDataValue
        XCTAssertEqual(userDefaultData, newDataValue)

        // Default value again
        UserDefaults.standard.reset()
        XCTAssertEqual(userDefaultData, defaultDataValue)
    }

    private func _testOptionalUserDefaultString() {
        // Default value
        XCTAssertNil(optionalUserDefaultString)

        // Updated value
        optionalUserDefaultString = newStringValue
        XCTAssertEqual(optionalUserDefaultString, newStringValue)
        optionalUserDefaultString = nil
        XCTAssertNil(optionalUserDefaultString)

        // Default value again
        UserDefaults.standard.reset()
        XCTAssertNil(optionalUserDefaultString)
    }

    private func _testOptionalUserDefaultBool() {
        // Default value
        XCTAssertNil(optionalUserDefaultBool)

        // Updated value
        optionalUserDefaultBool = newBoolValue
        XCTAssertEqual(optionalUserDefaultBool, newBoolValue)
        optionalUserDefaultBool = nil
        XCTAssertNil(optionalUserDefaultBool)

        // Default value again
        UserDefaults.standard.reset()
        XCTAssertNil(optionalUserDefaultBool)
    }

    private func _testOptionalUserDefaultData() {
        // Default value
        XCTAssertNil(optionalUserDefaultData)

        // Updated value
        optionalUserDefaultData = newDataValue
        XCTAssertEqual(optionalUserDefaultData, newDataValue)
        optionalUserDefaultData = nil
        XCTAssertNil(optionalUserDefaultData)

        // Default value again
        UserDefaults.standard.reset()
        XCTAssertNil(optionalUserDefaultData)
    }

    private func _testKeychainString() {
        // Default value
        XCTAssertEqual(keychainString, defaultStringValue)

        // Updated value
        keychainString = newStringValue
        XCTAssertEqual(keychainString, newStringValue)

        // Default value again
        KeychainSwift().reset()
        XCTAssertEqual(keychainString, defaultStringValue)
    }

    private func _testKeychainBool() {
        // Default value
        XCTAssertEqual(keychainBool, defaultBoolValue)

        // Updated value
        keychainBool = newBoolValue
        XCTAssertEqual(keychainBool, newBoolValue)

        // Default value again
        KeychainSwift().reset()
        XCTAssertEqual(keychainBool, defaultBoolValue)
    }

    private func _testKeychainData() {
        // Default value
        XCTAssertEqual(keychainData, defaultDataValue)

        // Updated value
        keychainData = newDataValue
        XCTAssertEqual(keychainData, newDataValue)

        // Default value again
        KeychainSwift().reset()
        XCTAssertEqual(keychainData, defaultDataValue)
    }

}

enum Keys: String, CaseIterable {
    case testStringKey
    case testBoolKey
    case testDataKey
    case testOptionalStringKey
    case testOptionalBoolKey
    case testOptionalDataKey
}

extension UserDefaults {
    func reset() {
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }
}

extension KeychainSwift {
    func reset() {
        Keys.allCases.forEach { delete($0.rawValue) }
    }
}

extension UserDefault.Key {
    static var testUserDefaultStringKey: Self { .init(Keys.testStringKey.rawValue) }
    static var testUserDefaultBoolKey: Self { .init(Keys.testBoolKey.rawValue) }
    static var testUserDefaultDataKey: Self { .init(Keys.testDataKey.rawValue) }

    static var testOptionalUserDefaultStringKey: Self { .init(Keys.testOptionalStringKey.rawValue) }
    static var testOptionalUserDefaultBoolKey: Self { .init(Keys.testOptionalBoolKey.rawValue) }
    static var testOptionalUserDefaultDataKey: Self { .init(Keys.testOptionalDataKey.rawValue) }
}

extension Keychain.Key {
    static var testKeychainStringKey: Self { .init(Keys.testStringKey.rawValue) }
    static var testKeychainBoolKey: Self { .init(Keys.testBoolKey.rawValue) }
    static var testKeychainDataKey: Self { .init(Keys.testDataKey.rawValue) }
}
