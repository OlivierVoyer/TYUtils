//
//  UserDefault.swift
//  TYUtils
//
//  Created by Olivier Voyer on 08/01/2021.
//

import Foundation

/**
 The `UserDefault` property wrapper is responsible for saving and loading a value from the user defaults automatically.

 ```swift
 @UserDefault(key: "isAppFirstInstall")
 var isAppFirstInstall: Bool = true
 ```

 NOTE: The value parameter can be only property list objects: NSData, NSString, NSNumber, NSDate, NSArray, or NSDictionary. For NSArray and NSDictionary objects, their contents must be property list objects. For more information, see What is a Property List? in Property List Programming Guide.
 */
@propertyWrapper
public final class UserDefault<T> {

    /// Key under which the data is stored in the user defaults
    private let key: Key

    /// Default value if no value has been stored for the given key with the correct type
    private let defaultValue: T

    /// User defaults object to use. By default, UserDefaults.standard
    private let defaults: UserDefaults

    /// Load/save the value to/from the user defaults
    public var wrappedValue: T {
        get { defaults.object(forKey: key.rawValue) as? T ?? defaultValue }
        set { defaults.set(newValue, forKey: key.rawValue) }
    }

    /// Use the key as the property wrapper projected value
    public var projectedValue: String { key.rawValue }

    /**
     Initializes a new property wrapper allowing the automatic loading/saving of any compatible value in the user Defaults.

     NOTE: The value parameter can be only property list objects: NSData, NSString, NSNumber, NSDate, NSArray, or NSDictionary. For NSArray and NSDictionary objects, their contents must be property list objects. For more information, see What is a Property List? in Property List Programming Guide.

     - Parameters:
        - wrappedValue: The default value if no value has been stored for the given key with the correct type
        - key: Key under which the data is stored in the user defaults
        - userDefault: User defaults object to use
     */
    public init(wrappedValue: T, key: Key, userDefault: UserDefaults = .standard) {
        self.defaultValue = wrappedValue
        self.key = key
        self.defaults = userDefault
    }

}

// MARK: Key type definition

public extension UserDefault {

    /**
     The type used for the key for a user defaults entry
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

extension UserDefault.Key: ExpressibleByStringLiteral {
    public init(stringLiteral value: StaticString) {
        self.init(rawValue: "\(value)")
    }
}
