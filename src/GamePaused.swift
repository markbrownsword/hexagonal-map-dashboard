//
//  GamePaused.swift
//
//  Created by MARK BROWNSWORD on 11/9/17.
//  Copyright © 2017 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

class GamePaused : SceneStateBase {

    override func isValidNextState(_ stateClass: Swift.AnyClass) -> Bool {
        return stateClass == PlayerTurn.self
    }
    
    override func didEnter(from previousState: GKState?) {
        // TODO: Interrupt any running actions e.g. Rover moving
    }
}
