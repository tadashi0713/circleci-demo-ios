//
//  CircleCIDemoUITests.swift
//  CircleCIDemoUITests
//
//  Created by Tadashi Nemoto on 2021/11/20.
//

import XCTest

class CircleCIDemoUITests1: XCTestCase {
    func testTapButton1() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Elements
        let text = app.staticTexts["text"]
        let button = app.buttons["button"]
        
        XCTAssertEqual(text.label, "Hello, world!")
        sleep(10)
        button.tap()
        XCTAssertEqual(text.label, "Button Tapped!")
    }
}
