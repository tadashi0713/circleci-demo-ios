//
//  CircleCIDemoUITests8.swift
//  CircleCIDemoUITests
//
//  Created by Tadashi Nemoto on 2023/05/28.
//

import XCTest

class CircleCIDemoUITests8: XCTestCase {
    func testTapButton8() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Elements
        let text = app.staticTexts["text"]
        let button = app.buttons["button"]

        sleep(80)
        button.tap()
        XCTAssertEqual(text.label, "Button Tapped!")
    }
}
