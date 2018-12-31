//
//  SETPlayerButtonProtocol.swift
//  Set
//
//  Created by Kelly Morales on 12/31/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import Foundation

/// Functions that affect the game board when a player button is selected
protocol SETPlayerButtonProtocol: AnyObject {
    /// Contains logic for when a player button is in it's selecting state
    func playerSelecting()

    /// Contains logic for when a player button has just completed it's selecting state
    func playerStoppedSelecting()
}
