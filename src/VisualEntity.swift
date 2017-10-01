//
//  VisualEntity.swift
//
//  Created by MARK BROWNSWORD on 15/10/16.
//  Copyright © 2016 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol VisualEntity {
    weak var delegate: GamePlayScene! { get set }

    var type: EntityType! { get }
    var node: SKSpriteNode! { get }
    var name: String! { get }
    var stateMachine: GKStateMachine! { get }
    var healthIndicator: SKShapeNode! { get }

    func component<ComponentType : GKComponent>(ofType componentClass: ComponentType.Type) -> ComponentType?
}
