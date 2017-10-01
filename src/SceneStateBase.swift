//
//  SceneStateBase.swift
//
//  Created by MARK BROWNSWORD on 11/9/17.
//  Copyright © 2017 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

class SceneStateBase : GKState {
    private(set) var tileMapScene : TileMapScene

    init(tileMapScene: TileMapScene) {
        self.tileMapScene = tileMapScene
    }
}
