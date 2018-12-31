//
//  SETGameBoardProtocol.swift
//  Set
//
//  Created by Kelly Morales on 12/31/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import UIKit

/// Protocol defining an object that contains the gameBoard collectionView, generally a UIViewController
protocol SETGameBoardProtocol: AnyObject {
    var gameBoard: UICollectionView? { get set }
}
