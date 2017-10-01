//
//  TileMapScene.swift
//
//  Created by MARK BROWNSWORD on 5/9/16.
//  Copyright © 2016 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol TileMapScene : GamePlayScene {
    var backgroundLayer: SKTileMapNode! { get set }
    var gridLayer: SKTileMapNode! { get set }
    var selectionLayer: SKTileMapNode! { get set }
    var objectLayer: SKTileMapNode! { get set }

    var dash: Dashboard! { get set }
    var gameScene: SKScene! { get }
    var gameDelegate: GameDelegate! { get set }
    
    var camera: SKCameraNode? { get }
    var scaleMode: SKSceneScaleMode { get set }
    var size: CGSize { get set }

    func setupDash()
}
