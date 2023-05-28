//
//  CircleCIDemoUITests10.swift
//  CircleCIDemoUITests
//
//  Created by Tadashi Nemoto on 2023/05/28.
//

import XCTest

class CircleCIDemoUITests10: XCTestCase {
    func testTapButton10() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Elements
        let text = app.staticTexts["text"]
        let button = app.buttons["button"]
        
        XCTAssertEqual(text.label, "Hello, world!")
        sleep(100)
        button.tap()
        XCTAssertEqual(text.label, "Button Tapped!")
    }
}
