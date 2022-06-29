//
//  CircleCIDemoUITests4.swift
//  CircleCIDemoUITests
//
//  Created by Tadashi Nemoto on 2022/06/26.
//

import XCTest

class CircleCIDemoUITests4: XCTestCase {
    func testTapButton4() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Elements
        let text = app.staticTexts["text"]
        let button = app.buttons["button"]
        
        XCTAssertEqual(text.label, "Hello, world!")
        sleep(40)
        button.tap()
        XCTAssertEqual(text.label, "Button Tapped!")
    }
}
