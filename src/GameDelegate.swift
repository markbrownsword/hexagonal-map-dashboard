//
//  GameDelegate.swift
//
//  Created by MARK BROWNSWORD on 30/9/17.
//  Copyright © 2017 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol GameDelegate {
    func saveScene(gameFolder folder: String, scene: GamePlayScene)
}
