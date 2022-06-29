//
//  CircleCIDemoUITests2.swift
//  CircleCIDemoUITests
//
//  Created by Tadashi Nemoto on 2022/06/26.
//

import XCTest

class CircleCIDemoUITests2: XCTestCase {
    func testTapButton2() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Elements
        let text = app.staticTexts["text"]
        let button = app.buttons["button"]
        
        XCTAssertEqual(text.label, "Hello, world!")
        sleep(20)
        button.tap()
        XCTAssertEqual(text.label, "Button Tapped!")
    }
}
