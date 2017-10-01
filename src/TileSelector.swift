//
//  TileSelector.swift
//
//  Created by MARK BROWNSWORD on 9/9/17.
//  Copyright © 2017 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol TileSelector: class {
    func addSelection(at targetLocation: CGPoint)
    func removeSelection()
}
