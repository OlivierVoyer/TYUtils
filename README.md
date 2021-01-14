# TYUtils

[![Build Status](https://travis-ci.com/OlivierVoyer/TYUtils.svg)](https://travis-ci.com/OlivierVoyer/TYUtils)
[![Version](https://img.shields.io/cocoapods/v/TYUtils.svg?style=flat)](https://cocoapods.org/pods/TYUtils)
[![License](https://img.shields.io/cocoapods/l/TYUtils.svg?style=flat)](https://cocoapods.org/pods/TYUtils)
[![Platform](https://img.shields.io/cocoapods/p/TYUtils.svg?style=flat)](https://cocoapods.org/pods/TYUtils)
[![Documentation](https://oliviervoyer.github.io/TYUtils/badge.svg)](https://oliviervoyer.github.io/TYUtils)

A set of iOS helpers and extensions to help writing smart, robust, clear and perfomant code.

## Installation

TYUtils is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TYUtils'       # Pull in all TYUtils features
```

If you don't want to use all of TYUtils, there are multiple subspecs which can selectively install subsets of the full feature set:

```ruby
# Only pull in Property Wrappers features
pod 'TYUtils/PropertyWrappers'
# Only pull in Extensions features
pod 'TYUtils/Extensions'
```

## Documentation

The complete API reference is available [here](https://oliviervoyer.github.io/TYUtils).

The READMEs for components of TYUtils can be found in their respective
project folders.

- [Property Wrappers](Sources/Property%20Wrappers/README.md)
- [Extensions](Sources/Extensions/README.md)

## Local Setup

If you'd like to contribute to TYUtils, you'll need to run the
following commands to get your environment set up:

```bash
$ git clone https://github.com/OlivierVoyer/TYUtils.git
$ cd TYUtils
$ pod install --project-directory=Example
```

Alternatively you can use `pod try TYUtils` to install the example project.

## Contributing to TYUtils

### Contribution Process

1. Submit an issue describing your proposed change to the repo in question.
1. The repo owner will respond to your issue promptly.
1. Fork the desired repo, develop and test your code changes.
1. Ensure that your code adheres to the existing style of the library to which
   you are contributing.
1. Ensure that your code has an appropriate set of unit tests which all pass.
1. Submit a pull request

## Author

Olivier Voyer, olivier@tekiteazy.com

## License

TYUtils is available under the MIT license. See the LICENSE file for more info.
