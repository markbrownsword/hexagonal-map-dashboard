//
//  OpponentTurn.swift
//
//  Created by MARK BROWNSWORD on 11/9/17.
//  Copyright © 2017 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

class OpponentTurn : SceneStateBase {
    
    override func isValidNextState(_ stateClass: Swift.AnyClass) -> Bool {
        return stateClass == PlayerTurn.self || stateClass == GamePaused.self || stateClass == GameOver.self
    }

    override func update(deltaTime seconds: TimeInterval) {
        // TODO: Filter componentSystems to those related to PlayerTurn
    }
}
