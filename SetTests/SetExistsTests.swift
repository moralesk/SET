//
//  SetExistsTests.swift
//  SetTests
//
//  Created by Kelly Morales on 12/26/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import XCTest

class SetExistsTests: XCTestCase {

    var setFinderDelegate: TestSetFinderDelegate?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        setFinderDelegate = TestSetFinderDelegate()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        setFinderDelegate = nil
    }

    func testNotEnoughCards() {
        let card = Card(with: .black, shape: .circle, fill: .empty, count: .one)

        guard let delegate = setFinderDelegate else {
            return
        }

        let result = delegate.setExists(in: [card])
        XCTAssertEqual(result, false)
    }

    func testExactlyEnoughCardsWithSet() {
        let card1 = Card(with: .black, shape: .circle, fill: .empty, count: .one)
        let card2 = Card(with: .black, shape: .circle, fill: .empty, count: .two)
        let card3 = Card(with: .black, shape: .circle, fill: .empty, count: .three)

        guard let delegate = setFinderDelegate else {
            return
        }

        let result = delegate.setExists(in: [card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testExactlyEnoughCardsWithoutSet() {
        let card1 = Card(with: .black, shape: .circle, fill: .empty, count: .one)
        let card2 = Card(with: .black, shape: .circle, fill: .empty, count: .two)
        let card3 = Card(with: .black, shape: .circle, fill: .empty, count: .two)

        guard let delegate = setFinderDelegate else {
            return
        }

        let result = delegate.setExists(in: [card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testMultipleSetsExist() {
        let card1 = Card(with: .red, shape: .circle, fill: .filled, count: .one)
        let card2 = Card(with: .red, shape: .square, fill: .empty, count: .one)
        let card3 = Card(with: .red, shape: .triangle, fill: .striped, count: .two)
        let card4 = Card(with: .red, shape: .triangle, fill: .filled, count: .two)
        let card5 = Card(with: .red, shape: .circle, fill: .empty, count: .three)
        let card6 = Card(with: .black, shape: .circle, fill: .empty, count: .one)
        let card7 = Card(with: .black, shape: .circle, fill: .striped, count: .two)
        let card8 = Card(with: .black, shape: .circle, fill: .filled, count: .three)
        let card9 = Card(with: .black, shape: .triangle, fill: .striped, count: .three)
        let card10 = Card(with: .blue, shape: .square, fill: .striped, count: .one)
        let card11 = Card(with: .blue, shape: .triangle, fill: .striped, count: .two)
        let card12 = Card(with: .blue, shape: .triangle, fill: .empty, count: .three)

        guard let delegate = setFinderDelegate else {
            return
        }

        let result = delegate.setExists(in: [card1, card2, card3, card4, card5, card6, card7, card8, card9, card10, card11, card12])
        XCTAssertEqual(result, true)
    }

    func testNoSetExists() {
        let card1 = Card(with: .blue, shape: .triangle, fill: .filled, count: .one)
        let card2 = Card(with: .red, shape: .square, fill: .striped, count: .two)
        let card3 = Card(with: .red, shape: .circle, fill: .empty, count: .one)
        let card4 = Card(with: .red, shape: .square, fill: .filled, count: .one)
        let card5 = Card(with: .black, shape: .triangle, fill: .striped, count: .two)
        let card6 = Card(with: .blue, shape: .triangle, fill: .filled, count: .three)
        let card7 = Card(with: .red, shape: .square, fill: .striped, count: .three)
        let card8 = Card(with: .blue, shape: .circle, fill: .empty, count: .two)
        let card9 = Card(with: .blue, shape: .square, fill: .empty, count: .two)
        let card10 = Card(with: .blue, shape: .triangle, fill: .empty, count: .one)
        let card11 = Card(with: .black, shape: .square, fill: .empty, count: .three)
        let card12 = Card(with: .red, shape: .triangle, fill: .striped, count: .two)

        guard let delegate = setFinderDelegate else {
            return
        }

        let result = delegate.setExists(in: [card1, card2, card3, card4, card5, card6, card7, card8, card9, card10, card11, card12])
        XCTAssertEqual(result, false)
    }
}
