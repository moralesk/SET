//
//  SETGameBoardDataSourceProtocol.swift
//  Set
//
//  Created by Kelly Morales on 12/31/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import Foundation

/// Protocol to abstract data source logic from the GameBoardViewController
protocol SETGameBoardDataSourceProtocol: AnyObject {
    /// A reference to an object that contains the gameBoard, generally a UIViewController
    var gameBoardDelegate: SETGameBoardProtocol? { get set }

    /// Creates UI elements for the possible number of players
    func setupPlayerElements()

    /**
     Used to finish adding constraints to the game board since the game board is placed in view
     after, and in respect to, the player elements
     */
    func completeGameBoardConstraints()

    /// Handler for a player selecting a SET, with a flag for if the SET was valid or not
    func processSet(valid: Bool)
}
