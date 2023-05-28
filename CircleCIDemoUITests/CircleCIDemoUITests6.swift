//
//  CircleCIDemoUITests6.swift
//  CircleCIDemoUITests
//
//  Created by Tadashi Nemoto on 2023/05/27.
//

import XCTest

class CircleCIDemoUITests6: XCTestCase {
    func testTapButton6() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Elements
        let text = app.staticTexts["text"]
        let button = app.buttons["button"]
        
        XCTAssertEqual(text.label, "Hello, world!")
        sleep(60)
        button.tap()
        XCTAssertEqual(text.label, "Button Tapped!")
    }
}
