//
//  VisualEntityMoving.swift
//
//  Created by MARK BROWNSWORD on 28/11/16.
//  Copyright © 2016 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

class VisualEntityMoving: GKState {
    override func isValidNextState(_ stateClass: Swift.AnyClass) -> Bool {
        return stateClass == VisualEntityIdle.self
    }
}
