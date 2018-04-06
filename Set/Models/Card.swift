//
//  Card.swift
//  Set
//
//  Created by Kelly Morales on 4/6/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import Foundation

class Card {
    enum Color: Int {
        case red = 0
        case black
        case blue
        case count
    }

    enum Shape: Int {
        case square = 0
        case triangle
        case circle
        case count
    }

    enum Fill: Int {
        case empty = 0
        case filled
        case striped
        case count
    }

    enum Count: Int {
        case one = 0
        case two
        case three
        case count
    }

    let color: Color
    let shape: Shape
    let fill: Fill
    let count: Count

    init(with color: Color, shape: Shape, fill: Fill, count: Count) {
        self.color = color
        self.shape = shape
        self.fill = fill
        self.count = count
    }
}
