//
//  SETGameBoardButtonProtocol.swift
//  Set
//
//  Created by Kelly Morales on 12/31/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import Foundation

/// Functions that affect the game board when a player button is selected
protocol SETGameBoardButtonProtocol: AnyObject {
    func playerSelecting()
    func playerStoppedSelecting()
}
