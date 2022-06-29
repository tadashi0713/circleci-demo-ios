//
//  CircleCIDemoUITests3.swift
//  CircleCIDemoUITests
//
//  Created by Tadashi Nemoto on 2022/06/26.
//

import XCTest

class CircleCIDemoUITests3: XCTestCase {
    func testTapButton3() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Elements
        let text = app.staticTexts["text"]
        let button = app.buttons["button"]
        
        XCTAssertEqual(text.label, "Hello, world!")
        sleep(30)
        button.tap()
        XCTAssertEqual(text.label, "Button Tapped!")
    }
}
