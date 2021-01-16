# TYUtils - Property Wrappers

TYUtils provides a handful of property wrappers ("Property Wrappers" section in the [The Swift Programming Language](https://docs.swift.org/swift-book/LanguageGuide/Properties.html)).

## API Overview

### UserDefault

The `UserDefault` property wrapper is responsible for saving and loading a value from the user defaults automatically.

```swift
@UserDefault(key: "isAppFirstInstall")
var isAppFirstInstall: Bool = true
```

NOTE: The value parameter can be only property list objects: NSData, NSString, NSNumber, NSDate, NSArray, or NSDictionary. For NSArray and NSDictionary objects, their contents must be property list objects. For more information, see What is a Property List? in Property List Programming Guide.

### Keychain

The `Keychain` property wrapper is responsible for saving and loading a value from the user keychain automatically.

NOTE: The current implementation is using the [KeychainSwift](https://github.com/evgenyneu/keychain-swift) library.

```swift
@Keychain(key: "isAppFirstInstallEver",
          synchronizable: true,
          keyPrefix: "com.tekiteazy.TYUtils_Example.")
var isAppFirstInstallEver: Bool = true
```

NOTE: The value parameter can be only one of String, Bool or Data.
