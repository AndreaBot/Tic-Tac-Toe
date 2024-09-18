//
//  XCUITestSandboxUITests.swift
//  XCUITestSandboxUITests
//
//  Created by Andrea Bottino on 18/09/2024.
//

import XCTest

final class XCUITestSandboxUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testXColorSelection() {
        let app = XCUIApplication()
        app.launch()
        let xColorWell = app.colorWells.element(boundBy: 0)
        xColorWell.tap()
        let elementsQuery = app.scrollViews.otherElements
            elementsQuery.otherElements["dark purple 28"].tap()
        elementsQuery.buttons["close"].tap()
    }
    
    func testOColorSelection() {
        let app = XCUIApplication()
        app.launch()
        let oColorWell = app.colorWells.element(boundBy: 1)
        oColorWell.tap()
        let elementsQuery = app.scrollViews.otherElements
            elementsQuery.otherElements["dark red 29"].tap()
        elementsQuery.buttons["close"].tap()
    }
    
    func testFlow() {
        let app = XCUIApplication()
        app.launch()
        let xColorWell = app.colorWells.element(boundBy: 0)
        xColorWell.tap()
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.otherElements["dark purple 28"].tap()
        elementsQuery.buttons["close"].tap()
        
        let oColorWell = app.colorWells.element(boundBy: 1)
        oColorWell.tap()
        elementsQuery.otherElements["dark red 29"].tap()
        elementsQuery.buttons["close"].tap()
        
        app.buttons["START"].tap()
        
        app.buttons["topLeft"].tap()
        app.buttons["bottomLeft"].tap()
        app.buttons["middle"].tap()
        app.buttons["left"].tap()
        app.buttons["bottomRight"].tap()
        
        XCTAssertEqual(app.staticTexts["turnLabel1"].label, "X WINS!")
    }
}
