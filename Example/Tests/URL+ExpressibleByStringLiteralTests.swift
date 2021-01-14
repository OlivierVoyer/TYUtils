//
//  URL+ExpressibleByStringLiteralTests.swift
//  TYUtils_Tests
//
//  Created by Olivier Voyer on 14/01/2021.
//  Copyright © 2021 TekITEazy. All rights reserved.
//

import XCTest
@testable import TYUtils

class URLExpressibleByStringLiteralTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testURL_ExpressibleByStringLiteral() throws {
        let referenceURL: URL! = URL(string: "http://www.apple.com")
        let testURL: URL = "http://www.apple.com"
        XCTAssertEqual(testURL, referenceURL)
    }

}
