//
//  GameOver.swift
//
//  Created by MARK BROWNSWORD on 11/9/17.
//  Copyright © 2017 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameOver : SceneStateBase {
    
    override func isValidNextState(_ stateClass: Swift.AnyClass) -> Bool {
        return stateClass == PlayerTurn.self || stateClass == OpponentTurn.self
    }

    override func didEnter(from previousState: GKState?) {
        // TODO: Notify scene that game is over...
    }
}
