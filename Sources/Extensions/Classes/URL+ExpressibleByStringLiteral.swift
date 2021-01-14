//
//  URL+ExpressibleByStringLiteral.swift
//  TYUtils
//
//  Created by Olivier Voyer on 14/01/2021.
//

import Foundation

/**
 This extension is a code shortcut to initialize a URL object from a valid static string.
 
 ```swift
 let myURL: URL = "myURLStringValue"
 ```
 */
extension URL: ExpressibleByStringLiteral {

    /**
     Creates a URL instance from the provided string.

     This initializer fails if the string doesn’t represent a valid URL. For example, an empty string or one containing characters that are illegal in a URL.

     ```swift
     let myURL: URL = "myURLStringValue"
     ```

     Will be equivalent to

     ```swift
     let myURL: URL = URL(string: "myURLStringValue")!
     ```
     */
    public init(stringLiteral value: StaticString) {
        self.init(string: "\(value)")!
    }

}
