# TYUtils - Property Wrappers

TYUtils provides a handful of property wrappers ("Property Wrappers" section in the [The Swift Programming Language](https://docs.swift.org/swift-book/LanguageGuide/Properties.html)).

## API Overview

### UserDefault

The `UserDefault` property wrapper is responsible for saving and loading a value from the user defaults automatically.

```swift
@UserDefault(key: "isAppFirstInstall")
var isAppFirstInstall: Bool = true
```

### Keychain

The `Keychain` property wrapper is responsible for saving and loading a value from the user keychain automatically.

NOTE: The current implementation is using the [KeychainSwift](https://github.com/evgenyneu/keychain-swift) library.

```swift
@Keychain(key: "isAppFirstInstallEver",
          synchronizable: true,
          keyPrefix: "com.tekiteazy.TYUtils_Example.")
var isAppFirstInstallEver: Bool = true
```
