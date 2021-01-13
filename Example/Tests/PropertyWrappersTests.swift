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
    var testUserDefaultStringKey: String = defaultStringValue

    @UserDefault(key: .testUserDefaultBoolKey)
    var testUserDefaultBoolKey: Bool = defaultBoolValue

    @UserDefault(key: .testUserDefaultDataKey)
    var testUserDefaultDataKey: Data = defaultDataValue

    func testUserDefault() throws {
        _testUserDefaultString()
        _testUserDefaultBool()
        _testUserDefaultData()
    }

    @Keychain(key: .testKeychainStringKey)
    var testKeychainStringKey: String = defaultStringValue

    @Keychain(key: .testKeychainBoolKey)
    var testKeychainBoolKey: Bool = defaultBoolValue

    @Keychain(key: .testKeychainDataKey)
    var testKeychainDataKey: Data = defaultDataValue

    func testKeychain() throws {
        _testKeychainString()
        _testKeychainBool()
        _testKeychainData()
    }

    private func _testUserDefaultString() {
        // Default value
        XCTAssertEqual(testUserDefaultStringKey, defaultStringValue)

        // Updated value
        testUserDefaultStringKey = newStringValue
        XCTAssertEqual(testUserDefaultStringKey, newStringValue)

        // Default value again
        UserDefaults.standard.reset()
        XCTAssertEqual(testUserDefaultStringKey, defaultStringValue)
    }

    private func _testUserDefaultBool() {
        // Default value
        XCTAssertEqual(testUserDefaultBoolKey, defaultBoolValue)

        // Updated value
        testUserDefaultBoolKey = newBoolValue
        XCTAssertEqual(testUserDefaultBoolKey, newBoolValue)

        // Default value again
        UserDefaults.standard.reset()
        XCTAssertEqual(testUserDefaultBoolKey, defaultBoolValue)
    }

    private func _testUserDefaultData() {
        // Default value
        XCTAssertEqual(testUserDefaultDataKey, defaultDataValue)

        // Updated value
        testUserDefaultDataKey = newDataValue
        XCTAssertEqual(testUserDefaultDataKey, newDataValue)

        // Default value again
        UserDefaults.standard.reset()
        XCTAssertEqual(testUserDefaultDataKey, defaultDataValue)
    }

    private func _testKeychainString() {
        // Default value
        XCTAssertEqual(testKeychainStringKey, defaultStringValue)

        // Updated value
        testKeychainStringKey = newStringValue
        XCTAssertEqual(testKeychainStringKey, newStringValue)

        // Default value again
        KeychainSwift().reset()
        XCTAssertEqual(testKeychainStringKey, defaultStringValue)
    }

    private func _testKeychainBool() {
        // Default value
        XCTAssertEqual(testKeychainBoolKey, defaultBoolValue)

        // Updated value
        testKeychainBoolKey = newBoolValue
        XCTAssertEqual(testKeychainBoolKey, newBoolValue)

        // Default value again
        KeychainSwift().reset()
        XCTAssertEqual(testKeychainBoolKey, defaultBoolValue)
    }

    private func _testKeychainData() {
        // Default value
        XCTAssertEqual(testKeychainDataKey, defaultDataValue)

        // Updated value
        testKeychainDataKey = newDataValue
        XCTAssertEqual(testKeychainDataKey, newDataValue)

        // Default value again
        KeychainSwift().reset()
        XCTAssertEqual(testKeychainDataKey, defaultDataValue)
    }

}

enum Keys: String, CaseIterable {
    case testStringKey
    case testBoolKey
    case tesDataKey
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
    static var testUserDefaultDataKey: Self { .init(Keys.tesDataKey.rawValue) }
}

extension Keychain.Key {
    static var testKeychainStringKey: Self { .init(Keys.testStringKey.rawValue) }
    static var testKeychainBoolKey: Self { .init(Keys.testBoolKey.rawValue) }
    static var testKeychainDataKey: Self { .init(Keys.tesDataKey.rawValue) }
}
