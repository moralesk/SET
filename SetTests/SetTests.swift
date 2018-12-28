//
//  SetTests.swift
//  SetTests
//
//  Created by Kelly Morales on 12/23/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import XCTest

class TestSetFinderDelegate: SetFinderProtocol {
}

class SetTests: XCTestCase {

    var setFinderDelegate: TestSetFinderDelegate?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        setFinderDelegate = TestSetFinderDelegate()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        setFinderDelegate = nil
    }

    func testOnlyColorsAreEqual() {
        let card1 = Card(with: Card.Color.red, shape: Card.Shape.square, fill: Card.Fill.empty, count: Card.Count.one)
        let card2 = Card(with: Card.Color.red, shape: Card.Shape.circle, fill: Card.Fill.filled, count: Card.Count.two)
        let card3 = Card(with: Card.Color.red, shape: Card.Shape.triangle, fill: Card.Fill.striped, count: Card.Count.three)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testOnlyShapesAreEqual() {
        let card1 = Card(with: Card.Color.red, shape: Card.Shape.square, fill: Card.Fill.empty, count: Card.Count.one)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.square, fill: Card.Fill.filled, count: Card.Count.two)
        let card3 = Card(with: Card.Color.blue, shape: Card.Shape.square, fill: Card.Fill.striped, count: Card.Count.three)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testOnlyFillsAreEqual() {
        let card1 = Card(with: Card.Color.red, shape: Card.Shape.square, fill: Card.Fill.empty, count: Card.Count.one)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card3 = Card(with: Card.Color.blue, shape: Card.Shape.triangle, fill: Card.Fill.empty, count: Card.Count.three)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testOnlyCountsAreEqual() {
        let card1 = Card(with: Card.Color.red, shape: Card.Shape.square, fill: Card.Fill.empty, count: Card.Count.one)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.filled, count: Card.Count.one)
        let card3 = Card(with: Card.Color.blue, shape: Card.Shape.triangle, fill: Card.Fill.striped, count: Card.Count.one)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testAllColorsAreInequal() {
        let card1 = Card(with: Card.Color.red, shape: Card.Shape.circle, fill: Card.Fill.filled, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.filled, count: Card.Count.two)
        let card3 = Card(with: Card.Color.blue, shape: Card.Shape.circle, fill: Card.Fill.filled, count: Card.Count.two)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testAllShapesAreInequal() {
        let card1 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.filled, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.square, fill: Card.Fill.filled, count: Card.Count.two)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.triangle, fill: Card.Fill.filled, count: Card.Count.two)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testAllFillsAreInequal() {
        let card1 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.filled, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.striped, count: Card.Count.two)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testAllCountsAreInequal() {
        let card1 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.filled, count: Card.Count.one)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.filled, count: Card.Count.two)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.filled, count: Card.Count.three)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testInvalidSetUsingOneWrongColor() {
        let card1 = Card(with: Card.Color.red, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testInvalidSetUsingOneWrongShape() {
        let card1 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.square, fill: Card.Fill.empty, count: Card.Count.two)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testInvalidSetUsingOneWrongFill() {
        let card1 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.striped, count: Card.Count.two)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testInvalidSetUsingOneWrongCount() {
        let card1 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.one)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testInvalidSetUsingWrongColorAndShape() {
        let card1 = Card(with: Card.Color.red, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.square, fill: Card.Fill.empty, count: Card.Count.two)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testInvalidSetUsingWrongColorAndFill() {
        let card1 = Card(with: Card.Color.red, shape: Card.Shape.circle, fill: Card.Fill.striped, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testInvalidSetUsingWrongColorAndCount() {
        let card1 = Card(with: Card.Color.red, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.three)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testInvalidSetUsingWrongShapeAndFill() {
        let card1 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.striped, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.triangle, fill: Card.Fill.empty, count: Card.Count.two)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testInvalidSetUsingWrongShapeAndCount() {
        let card1 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.three)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.triangle, fill: Card.Fill.empty, count: Card.Count.two)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testInvalidSetUsingWrongFillAndCount() {
        let card1 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.filled, count: Card.Count.three)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testTwoCommonAttributes() {
        let card1 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.filled, count: Card.Count.two)
        let card2 = Card(with: Card.Color.blue, shape: Card.Shape.square, fill: Card.Fill.filled, count: Card.Count.two)
        let card3 = Card(with: Card.Color.red, shape: Card.Shape.triangle, fill: Card.Fill.filled, count: Card.Count.two)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testTwoCommonAttributes2() {
        let card1 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.one)
        let card2 = Card(with: Card.Color.blue, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.two)
        let card3 = Card(with: Card.Color.red, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.three)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testTwoCommonAttributes3() {
        let card1 = Card(with: Card.Color.red, shape: Card.Shape.square, fill: Card.Fill.empty, count: Card.Count.one)
        let card2 = Card(with: Card.Color.red, shape: Card.Shape.square, fill: Card.Fill.filled, count: Card.Count.two)
        let card3 = Card(with: Card.Color.red, shape: Card.Shape.square, fill: Card.Fill.striped, count: Card.Count.three)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testOneCommonAttribute() {
        let card1 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.one)
        let card2 = Card(with: Card.Color.blue, shape: Card.Shape.square, fill: Card.Fill.filled, count: Card.Count.two)
        let card3 = Card(with: Card.Color.red, shape: Card.Shape.triangle, fill: Card.Fill.striped, count: Card.Count.three)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testThreeCommonAttributes() {
        let card1 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.one)
        let card2 = Card(with: Card.Color.blue, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.one)
        let card3 = Card(with: Card.Color.red, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.one)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testImpossibleCaseOfFourCommonAttributes() {
        let card1 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.one)
        let card2 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.one)
        let card3 = Card(with: Card.Color.black, shape: Card.Shape.circle, fill: Card.Fill.empty, count: Card.Count.one)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testNoCommonAttributes() {
        let card1 = Card(with: .black, shape: .circle, fill: .empty, count: .one)
        let card2 = Card(with: .blue, shape: .square, fill: .filled, count: .two)
        let card3 = Card(with: .red, shape: .triangle, fill: .striped, count: .three)
        guard let delegate = setFinderDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }
}
