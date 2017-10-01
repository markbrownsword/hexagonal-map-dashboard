//
//  PlayerTurn.swift
//
//  Created by MARK BROWNSWORD on 11/9/17.
//  Copyright © 2017 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

class PlayerTurn : SceneStateBase {

    override func isValidNextState(_ stateClass: Swift.AnyClass) -> Bool {
        return stateClass == OpponentTurn.self || stateClass == GamePaused.self || stateClass == GameOver.self
    }

    override func didEnter(from previousState: GKState?) {
        guard self.tileMapScene.dash.ready else {
            fatalError("Dash not ready")
        }
        self.tileMapScene.dash.enableCommandButtons()
    }

    override func update(deltaTime seconds: TimeInterval) {
        for componentSystem in self.tileMapScene.componentSystems {
            componentSystem.update(deltaTime: seconds)
        }
    }

    override func willExit(to nextState: GKState) {

    }
}
