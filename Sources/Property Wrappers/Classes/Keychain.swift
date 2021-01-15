//
//  Keychain.swift
//  TYUtils
//
//  Created by Olivier Voyer on 08/01/2021.
//

import Foundation
import KeychainSwift

/**
 The `Keychain` property wrapper is responsible for saving and loading a value from the user keychain automatically.

 NOTE: The current implementation is using the [KeychainSwift](https://github.com/evgenyneu/keychain-swift) library.

 ```swift
 @Keychain(key: "isAppFirstInstallEver",
           synchronizable: true,
           keyPrefix: "com.tekiteazy.TYUtils_Example.")
 var isAppFirstInstallEver: Bool = true
 ```

 NOTE: The value parameter can be only one of String, Bool or Data.
 */
@propertyWrapper
public final class Keychain<T: KeychainStorable> {

    /// Key under which the data is stored in the keychain
    private let key: Key

    /// Default value if no value has been stored for the given key with the correct type
    private let defaultValue: T

    /// Keychain object to use
    private let keychain: KeychainSwift

    /// Value that indicates when your app needs access to the text in the keychain item. By default the .AccessibleWhenUnlocked option is used that permits the data to be accessed only while the device is unlocked by the user.
    private let access: KeychainSwiftAccessOptions?

    /// Load/save the value to/from the keychain
    public var wrappedValue: T {
        get { return T.get(from: keychain, key: key.rawValue) ?? defaultValue }
        set { T.set(newValue, in: keychain, forKey: key.rawValue, withAccess: access) }
    }

    /// Use the key as the property wrapper projected value
    public var projectedValue: String { key.rawValue }

    /**
     Initializes a new property wrapper allowing the automatic loading/saving of any compatible value in the keychain.

     NOTE: The value parameter can be only one of String, Bool or Data.

     - Parameters:
        - wrappedValue: The default value if no value has been stored for the given key with the correct type
        - key: Key under which the data is stored in the keychain
        - keychain: Keychain object to use
        - access: Value that indicates when your app needs access to the text in the keychain item. If omitted, the .AccessibleWhenUnlocked option is used that permits the data to be accessed only while the device is unlocked by the user.
     */
    public init(wrappedValue: T, key: Key, keychain: KeychainSwift = .init(),
                withAccess access: KeychainSwiftAccessOptions? = nil) {
        self.defaultValue = wrappedValue
        self.key = key
        self.keychain = keychain
        self.access = access
    }

    /**
     Initializes a new property wrapper allowing the automatic loading/saving of an optional value of any compatible value in the keychain.

     NOTE: The value parameter can be only one of String, Bool or Data.

     - Parameters:
        - key: Key under which the data is stored in the keychain
        - keychain: Keychain object to use
        - access: Value that indicates when your app needs access to the text in the keychain item. If omitted, the .AccessibleWhenUnlocked option is used that permits the data to be accessed only while the device is unlocked by the user.
     */
    public init<U>(key: Key, keychain: KeychainSwift = .init(),
                   withAccess access: KeychainSwiftAccessOptions? = nil) where T == U?, U: KeychainStorable {
        self.defaultValue = nil
        self.key = key
        self.keychain = keychain
        self.access = access
    }

}

// MARK: Convenience initializers

public extension Keychain {

    /**
     Initializes a new property wrapper allowing the automatic loading/saving of any compatible value in the keychain.

     NOTE: The value parameter can be only one of String, Bool or Data.

     - Parameters:
        - wrappedValue: The default value if no value has been stored for the given key with the correct type
        - key: Key under which the data is stored in the keychain
        - access: Value that indicates when your app needs access to the text in the keychain item. If omitted, the .AccessibleWhenUnlocked option is used that permits the data to be accessed only while the device is unlocked by the user.
        - synchronizable: Specifies whether the items can be synchronized with other devices through iCloud.
        - accessGroup: Specify an access group that will be used to access keychain items. In order to share keychain items between apps on the same device they need to have common Keychain Groups registered in Capabilities > Keychain Sharing settings.
        - keyPrefix: A prefix that is added before the key in get/set methods.
     */
    convenience init(wrappedValue: T, key: Key,
                     withAccess access: KeychainSwiftAccessOptions? = nil,
                     synchronizable: Bool = false, accessGroup: String? = nil, keyPrefix: String? = nil) {
        let keychain: KeychainSwift = {
            if let keyPrefix = keyPrefix {
                return KeychainSwift(keyPrefix: keyPrefix)
            }
            return KeychainSwift()
        }()
        keychain.synchronizable = synchronizable
        keychain.accessGroup = accessGroup
        self.init(wrappedValue: wrappedValue, key: key, keychain: keychain, withAccess: access)
    }

    /**
     Initializes a new property wrapper allowing the automatic loading/saving of an optional value of any compatible value in the keychain.

     NOTE: The value parameter can be only one of String, Bool or Data.

     - Parameters:
        - key: Key under which the data is stored in the keychain
        - access: Value that indicates when your app needs access to the text in the keychain item. If omitted, the .AccessibleWhenUnlocked option is used that permits the data to be accessed only while the device is unlocked by the user.
        - synchronizable: Specifies whether the items can be synchronized with other devices through iCloud.
        - accessGroup: Specify an access group that will be used to access keychain items. In order to share keychain items between apps on the same device they need to have common Keychain Groups registered in Capabilities > Keychain Sharing settings.
        - keyPrefix: A prefix that is added before the key in get/set methods.
     */
    convenience init<U>(key: Key,
                        withAccess access: KeychainSwiftAccessOptions? = nil,
                        synchronizable: Bool = false, accessGroup: String? = nil,
                        keyPrefix: String? = nil) where T == U?, U: KeychainStorable {
        let keychain: KeychainSwift = {
            if let keyPrefix = keyPrefix {
                return KeychainSwift(keyPrefix: keyPrefix)
            }
            return KeychainSwift()
        }()
        keychain.synchronizable = synchronizable
        keychain.accessGroup = accessGroup
        self.init(wrappedValue: nil, key: key, keychain: keychain, withAccess: access)
    }

}

// MARK: KeychainStorable Protocol

/**
 Ability for a given type to be loaded/saved from/to the keychain.
 */
public protocol KeychainStorable {

    /**
     Load a value from the keychain if it exists.

     - Parameters:
        - keychain: Keychain object to use
        - key: Key under which the data is stored in the keychain
     */
    static func get(from keychain: KeychainSwift, key: String) -> Self?

    /**
     Save a value to the keychain.

     - Parameters:
        - keychain: Keychain object to use
        - key: Key under which the data is stored in the keychain
     */
    @discardableResult
    static func set(_ value: Self, in keychain: KeychainSwift, forKey key: String, withAccess access: KeychainSwiftAccessOptions?) -> Bool

}

extension String: KeychainStorable {
    public static func get(from keychain: KeychainSwift, key: String) -> Self? {
        return keychain.get(key)
    }
    @discardableResult
    public static func set(_ value: Self, in keychain: KeychainSwift, forKey key: String, withAccess access: KeychainSwiftAccessOptions? = nil) -> Bool {
        return keychain.set(value, forKey: key, withAccess: access)
    }
}

extension Bool: KeychainStorable {
    public static func get(from keychain: KeychainSwift, key: String) -> Self? {
        return keychain.getBool(key)
    }
    @discardableResult
    public static func set(_ value: Self, in keychain: KeychainSwift, forKey key: String, withAccess access: KeychainSwiftAccessOptions? = nil) -> Bool {
        return keychain.set(value, forKey: key, withAccess: access)
    }
}

extension Data: KeychainStorable {
    public static func get(from keychain: KeychainSwift, key: String) -> Self? {
        return keychain.getData(key)
    }
    @discardableResult
    public static func set(_ value: Self, in keychain: KeychainSwift, forKey key: String, withAccess access: KeychainSwiftAccessOptions? = nil) -> Bool {
        return keychain.set(value, forKey: key, withAccess: access)
    }
}

extension Optional: KeychainStorable where Wrapped: KeychainStorable {
    public static func get(from keychain: KeychainSwift, key: String) -> Self? {
        return Wrapped.get(from: keychain, key: key)
    }
    @discardableResult
    public static func set(_ value: Self, in keychain: KeychainSwift, forKey key: String, withAccess access: KeychainSwiftAccessOptions? = nil) -> Bool {
        if let newValue = value {
            return Wrapped.set(newValue, in: keychain, forKey: key, withAccess: access)
        } else {
            return keychain.delete(key)
        }
    }
}

// MARK: Key type definition

public extension Keychain {

    /**
     The type used for the key for a keychain entry
     */
    struct Key: Hashable, Equatable, RawRepresentable {
        public let rawValue: String

        /// Same as `init(rawValue:)`
        public init(_ rawValue: String) {
            self.rawValue = rawValue
        }

        /**
         Creates a new instance with the specified raw value.

         - Parameter rawValue: The raw value to use for the new instance.
         */
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }

}

extension Keychain.Key: ExpressibleByStringLiteral {
    public init(stringLiteral value: StaticString) {
        self.init(rawValue: "\(value)")
    }
}
