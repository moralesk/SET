//
//  SetTests.swift
//  SetTests
//
//  Created by Kelly Morales on 12/23/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import XCTest

class SetTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOnlyColorsAreEqual() {
        let card1 = Card(with: Card.Color.red, shape: Card.Shape.square, fill: Card.Fill.empty, count: Card.Count.one)
        let card2 = Card(with: Card.Color.red, shape: Card.Shape.circle, fill: Card.Fill.filled, count: Card.Count.two)
        let card3 = Card(with: Card.Color.red, shape: Card.Shape.triangle, fill: Card.Fill.striped, count: Card.Count.three)
        let set = Set(cards: [card1, card2, card3])
        XCTAssertEqual(set.isSet(), true)
    }

    func testOnlyShapesAreEqual() {
        let card1 = Card(with: Card.Color.red, shape: Card.Shape.square, fill: Card.Fill.empty, count: Card.Count.one)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.square, fill: Card.Fill.filled, count: Card.Count.two)
        let card3 = Card(with: Card.Color.blue, shape: Card.Shape.square, fill: Card.Fill.striped, count: Card.Count.three)
        let set = Set(cards: [card1, card2, card3])
        XCTAssertEqual(set.isSet(), true)
    }

    func testOnlyFillsAreEqual() {
        let card1 = Card(with: Card.Color.red, shape: Card.Shape.square, fill: Card.Fill.empty, count: Card.Count.one)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card3 = Card(with: Card.Color.blue, shape: Card.Shape.triangle, fill: Card.Fill.empty, count: Card.Count.three)
        let set = Set(cards: [card1, card2, card3])
        XCTAssertEqual(set.isSet(), true)
    }

    func testOnlyCountsAreEqual() {
        let card1 = Card(with: Card.Color.red, shape: Card.Shape.square, fill: Card.Fill.empty, count: Card.Count.one)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.filled, count: Card.Count.one)
        let card3 = Card(with: Card.Color.blue, shape: Card.Shape.triangle, fill: Card.Fill.striped, count: Card.Count.one)
        let set = Set(cards: [card1, card2, card3])
        XCTAssertEqual(set.isSet(), true)
    }

    func testAllColorsAreInequal() {
        let card1 = Card(with: Card.Color.red, shape: Card.Shape.circle, fill: Card.Fill.filled, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.filled, count: Card.Count.two)
        let card3 = Card(with: Card.Color.blue, shape: Card.Shape.circle, fill: Card.Fill.filled, count: Card.Count.two)
        let set = Set(cards: [card1, card2, card3])
        XCTAssertEqual(set.isSet(), true)
    }

    func testAllShapesAreInequal() {
        let card1 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.filled, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.square, fill: Card.Fill.filled, count: Card.Count.two)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.triangle, fill: Card.Fill.filled, count: Card.Count.two)
        let set = Set(cards: [card1, card2, card3])
        XCTAssertEqual(set.isSet(), true)
    }

    func testAllFillsAreInequal() {
        let card1 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.filled, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.striped, count: Card.Count.two)
        let set = Set(cards: [card1, card2, card3])
        XCTAssertEqual(set.isSet(), true)
    }

    func testAllCountsAreInequal() {
        let card1 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.filled, count: Card.Count.one)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.filled, count: Card.Count.two)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.filled, count: Card.Count.three)
        let set = Set(cards: [card1, card2, card3])
        XCTAssertEqual(set.isSet(), true)
    }

    func testInvalidSetUsingOneWrongColor() {
        let card1 = Card(with: Card.Color.red, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let set = Set(cards: [card1, card2, card3])
        XCTAssertEqual(set.isSet(), false)
    }

    func testInvalidSetUsingOneWrongShape() {
        let card1 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.square, fill: Card.Fill.empty, count: Card.Count.two)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let set = Set(cards: [card1, card2, card3])
        XCTAssertEqual(set.isSet(), false)
    }

    func testInvalidSetUsingOneWrongFill() {
        let card1 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.striped, count: Card.Count.two)
        let set = Set(cards: [card1, card2, card3])
        XCTAssertEqual(set.isSet(), false)
    }

    func testInvalidSetUsingOneWrongCount() {
        let card1 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.one)
        let set = Set(cards: [card1, card2, card3])
        XCTAssertEqual(set.isSet(), false)
    }

    func testInvalidSetUsingWrongColorAndShape() {
        let card1 = Card(with: Card.Color.red, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.square, fill: Card.Fill.empty, count: Card.Count.two)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let set = Set(cards: [card1, card2, card3])
        XCTAssertEqual(set.isSet(), false)
    }

    func testInvalidSetUsingWrongColorAndFill() {
        let card1 = Card(with: Card.Color.red, shape: Card.Shape.circle, fill: Card.Fill.striped, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let set = Set(cards: [card1, card2, card3])
        XCTAssertEqual(set.isSet(), false)
    }

    func testInvalidSetUsingWrongColorAndCount() {
        let card1 = Card(with: Card.Color.red, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.three)
        let set = Set(cards: [card1, card2, card3])
        XCTAssertEqual(set.isSet(), false)
    }

    func testInvalidSetUsingWrongShapeAndFill() {
        let card1 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.striped, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.triangle, fill: Card.Fill.empty, count: Card.Count.two)
        let set = Set(cards: [card1, card2, card3])
        XCTAssertEqual(set.isSet(), false)
    }

    func testInvalidSetUsingWrongShapeAndCount() {
        let card1 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.three)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.triangle, fill: Card.Fill.empty, count: Card.Count.two)
        let set = Set(cards: [card1, card2, card3])
        XCTAssertEqual(set.isSet(), false)
    }

    func testInvalidSetUsingWrongFillAndCount() {
        let card1 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.filled, count: Card.Count.three)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let set = Set(cards: [card1, card2, card3])
        XCTAssertEqual(set.isSet(), false)
    }
}
