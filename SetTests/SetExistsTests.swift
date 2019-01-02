//
//  SetExistsTests.swift
//  SetTests
//
//  Created by Kelly Morales on 12/26/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import XCTest

class SetExistsTests: XCTestCase {

    var setValidationDelegate: TestSetValidationDelegate?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        setValidationDelegate = TestSetValidationDelegate()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        setValidationDelegate = nil
    }

    func testNotEnoughCards() {
        let card = SETCard(with: .black, shape: .circle, fill: .empty, count: .one)

        guard let delegate = setValidationDelegate else {
            return
        }

        let result = delegate.setExists(in: [card])
        XCTAssertEqual(result, false)
    }

    func testExactlyEnoughCardsWithSet() {
        let card1 = SETCard(with: .black, shape: .circle, fill: .empty, count: .one)
        let card2 = SETCard(with: .black, shape: .circle, fill: .empty, count: .two)
        let card3 = SETCard(with: .black, shape: .circle, fill: .empty, count: .three)

        guard let delegate = setValidationDelegate else {
            return
        }

        let result = delegate.setExists(in: [card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testExactlyEnoughCardsWithoutSet() {
        let card1 = SETCard(with: .black, shape: .circle, fill: .empty, count: .one)
        let card2 = SETCard(with: .black, shape: .circle, fill: .empty, count: .two)
        let card3 = SETCard(with: .black, shape: .circle, fill: .empty, count: .two)

        guard let delegate = setValidationDelegate else {
            return
        }

        let result = delegate.setExists(in: [card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testMultipleSetsExist() {
        let card1 = SETCard(with: .red, shape: .circle, fill: .filled, count: .one)
        let card2 = SETCard(with: .red, shape: .square, fill: .empty, count: .one)
        let card3 = SETCard(with: .red, shape: .triangle, fill: .striped, count: .two)
        let card4 = SETCard(with: .red, shape: .triangle, fill: .filled, count: .two)
        let card5 = SETCard(with: .red, shape: .circle, fill: .empty, count: .three)
        let card6 = SETCard(with: .black, shape: .circle, fill: .empty, count: .one)
        let card7 = SETCard(with: .black, shape: .circle, fill: .striped, count: .two)
        let card8 = SETCard(with: .black, shape: .circle, fill: .filled, count: .three)
        let card9 = SETCard(with: .black, shape: .triangle, fill: .striped, count: .three)
        let card10 = SETCard(with: .blue, shape: .square, fill: .striped, count: .one)
        let card11 = SETCard(with: .blue, shape: .triangle, fill: .striped, count: .two)
        let card12 = SETCard(with: .blue, shape: .triangle, fill: .empty, count: .three)

        guard let delegate = setValidationDelegate else {
            return
        }

        let result = delegate.setExists(in: [card1, card2, card3, card4, card5, card6, card7, card8, card9, card10, card11, card12])
        XCTAssertEqual(result, true)
    }

    func testNoSetExists() {
        let card1 = SETCard(with: .blue, shape: .triangle, fill: .filled, count: .one)
        let card2 = SETCard(with: .red, shape: .square, fill: .striped, count: .two)
        let card3 = SETCard(with: .red, shape: .circle, fill: .empty, count: .one)
        let card4 = SETCard(with: .red, shape: .square, fill: .filled, count: .one)
        let card5 = SETCard(with: .black, shape: .triangle, fill: .striped, count: .two)
        let card6 = SETCard(with: .blue, shape: .triangle, fill: .filled, count: .three)
        let card7 = SETCard(with: .red, shape: .square, fill: .striped, count: .three)
        let card8 = SETCard(with: .blue, shape: .circle, fill: .empty, count: .two)
        let card9 = SETCard(with: .blue, shape: .square, fill: .empty, count: .two)
        let card10 = SETCard(with: .blue, shape: .triangle, fill: .empty, count: .one)
        let card11 = SETCard(with: .black, shape: .square, fill: .empty, count: .three)
        let card12 = SETCard(with: .red, shape: .triangle, fill: .striped, count: .two)

        guard let delegate = setValidationDelegate else {
            return
        }

        let result = delegate.setExists(in: [card1, card2, card3, card4, card5, card6, card7, card8, card9, card10, card11, card12])
        XCTAssertEqual(result, false)
    }
}
