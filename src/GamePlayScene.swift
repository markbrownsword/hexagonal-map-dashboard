//
//  GamePlayScene.swift
//
//  Created by MARK BROWNSWORD on 5/11/16.
//  Copyright © 2016 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol GamePlayScene: class {
    var stateMachine: GKStateMachine! { get }
    
    var graph: HexGraph<HexGraphNode>! { get set }
    var componentSystems: [GKComponentSystem<GKComponent>]! { get set }
    var entities: [GKEntity]! { get set }

    func setupGraph()
    func setupComponentSystems()
    func setupEntities()
    func archiveEntities()
    
    func addChild(_ node: SKNode)
}
