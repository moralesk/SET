//
//  SetTests.swift
//  SetTests
//
//  Created by Kelly Morales on 12/23/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import XCTest

class TestSetValidationDelegate: SETValidationProtocol {
}

class SetTests: XCTestCase {

    var setValidationDelegate: TestSetValidationDelegate?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        setValidationDelegate = TestSetValidationDelegate()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        setValidationDelegate = nil
    }

    func testOnlyColorsAreEqual() {
        let card1 = SETCard(with: SETCard.Color.red, shape: SETCard.Shape.square, fill: SETCard.Fill.empty, count: SETCard.Count.one)
        let card2 = SETCard(with: SETCard.Color.red, shape: SETCard.Shape.circle, fill: SETCard.Fill.filled, count: SETCard.Count.two)
        let card3 = SETCard(with: SETCard.Color.red, shape: SETCard.Shape.triangle, fill: SETCard.Fill.striped, count: SETCard.Count.three)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testOnlyShapesAreEqual() {
        let card1 = SETCard(with: SETCard.Color.red, shape: SETCard.Shape.square, fill: SETCard.Fill.empty, count: SETCard.Count.one)
        let card2 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.square, fill: SETCard.Fill.filled, count: SETCard.Count.two)
        let card3 = SETCard(with: SETCard.Color.blue, shape: SETCard.Shape.square, fill: SETCard.Fill.striped, count: SETCard.Count.three)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testOnlyFillsAreEqual() {
        let card1 = SETCard(with: SETCard.Color.red, shape: SETCard.Shape.square, fill: SETCard.Fill.empty, count: SETCard.Count.one)
        let card2 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        let card3 = SETCard(with: SETCard.Color.blue, shape: SETCard.Shape.triangle, fill: SETCard.Fill.empty, count: SETCard.Count.three)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testOnlyCountsAreEqual() {
        let card1 = SETCard(with: SETCard.Color.red, shape: SETCard.Shape.square, fill: SETCard.Fill.empty, count: SETCard.Count.one)
        let card2 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.filled, count: SETCard.Count.one)
        let card3 = SETCard(with: SETCard.Color.blue, shape: SETCard.Shape.triangle, fill: SETCard.Fill.striped, count: SETCard.Count.one)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testAllColorsAreInequal() {
        let card1 = SETCard(with: SETCard.Color.red, shape: SETCard.Shape.circle, fill: SETCard.Fill.filled, count: SETCard.Count.two)
        let card2 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.filled, count: SETCard.Count.two)
        let card3 = SETCard(with: SETCard.Color.blue, shape: SETCard.Shape.circle, fill: SETCard.Fill.filled, count: SETCard.Count.two)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testAllShapesAreInequal() {
        let card1 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.filled, count: SETCard.Count.two)
        let card2 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.square, fill: SETCard.Fill.filled, count: SETCard.Count.two)
        let card3 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.triangle, fill: SETCard.Fill.filled, count: SETCard.Count.two)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testAllFillsAreInequal() {
        let card1 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.filled, count: SETCard.Count.two)
        let card2 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        let card3 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.striped, count: SETCard.Count.two)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testAllCountsAreInequal() {
        let card1 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.filled, count: SETCard.Count.one)
        let card2 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.filled, count: SETCard.Count.two)
        let card3 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.filled, count: SETCard.Count.three)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testInvalidSetUsingOneWrongColor() {
        let card1 = SETCard(with: SETCard.Color.red, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        let card2 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        let card3 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testInvalidSetUsingOneWrongShape() {
        let card1 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        let card2 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.square, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        let card3 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testInvalidSetUsingOneWrongFill() {
        let card1 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        let card2 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        let card3 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.striped, count: SETCard.Count.two)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testInvalidSetUsingOneWrongCount() {
        let card1 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        let card2 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        let card3 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.one)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testInvalidSetUsingWrongColorAndShape() {
        let card1 = SETCard(with: SETCard.Color.red, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        let card2 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.square, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        let card3 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testInvalidSetUsingWrongColorAndFill() {
        let card1 = SETCard(with: SETCard.Color.red, shape: SETCard.Shape.circle, fill: SETCard.Fill.striped, count: SETCard.Count.two)
        let card2 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        let card3 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testInvalidSetUsingWrongColorAndCount() {
        let card1 = SETCard(with: SETCard.Color.red, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        let card2 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        let card3 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.three)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testInvalidSetUsingWrongShapeAndFill() {
        let card1 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.striped, count: SETCard.Count.two)
        let card2 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        let card3 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.triangle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testInvalidSetUsingWrongShapeAndCount() {
        let card1 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        let card2 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.three)
        let card3 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.triangle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testInvalidSetUsingWrongFillAndCount() {
        let card1 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        let card2 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.filled, count: SETCard.Count.three)
        let card3 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testTwoCommonAttributes() {
        let card1 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.filled, count: SETCard.Count.two)
        let card2 = SETCard(with: SETCard.Color.blue, shape: SETCard.Shape.square, fill: SETCard.Fill.filled, count: SETCard.Count.two)
        let card3 = SETCard(with: SETCard.Color.red, shape: SETCard.Shape.triangle, fill: SETCard.Fill.filled, count: SETCard.Count.two)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testTwoCommonAttributes2() {
        let card1 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.one)
        let card2 = SETCard(with: SETCard.Color.blue, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.two)
        let card3 = SETCard(with: SETCard.Color.red, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.three)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testTwoCommonAttributes3() {
        let card1 = SETCard(with: SETCard.Color.red, shape: SETCard.Shape.square, fill: SETCard.Fill.empty, count: SETCard.Count.one)
        let card2 = SETCard(with: SETCard.Color.red, shape: SETCard.Shape.square, fill: SETCard.Fill.filled, count: SETCard.Count.two)
        let card3 = SETCard(with: SETCard.Color.red, shape: SETCard.Shape.square, fill: SETCard.Fill.striped, count: SETCard.Count.three)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testOneCommonAttribute() {
        let card1 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.one)
        let card2 = SETCard(with: SETCard.Color.blue, shape: SETCard.Shape.square, fill: SETCard.Fill.filled, count: SETCard.Count.two)
        let card3 = SETCard(with: SETCard.Color.red, shape: SETCard.Shape.triangle, fill: SETCard.Fill.striped, count: SETCard.Count.three)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testThreeCommonAttributes() {
        let card1 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.one)
        let card2 = SETCard(with: SETCard.Color.blue, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.one)
        let card3 = SETCard(with: SETCard.Color.red, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.one)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }

    func testImpossibleCaseOfFourCommonAttributes() {
        let card1 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.one)
        let card2 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.one)
        let card3 = SETCard(with: SETCard.Color.black, shape: SETCard.Shape.circle, fill: SETCard.Fill.empty, count: SETCard.Count.one)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, false)
    }

    func testNoCommonAttributes() {
        let card1 = SETCard(with: .black, shape: .circle, fill: .empty, count: .one)
        let card2 = SETCard(with: .blue, shape: .square, fill: .filled, count: .two)
        let card3 = SETCard(with: .red, shape: .triangle, fill: .striped, count: .three)
        guard let delegate = setValidationDelegate else {
            return
        }
        let result = delegate.isSet([card1, card2, card3])
        XCTAssertEqual(result, true)
    }
}
