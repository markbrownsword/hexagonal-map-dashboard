//
//  GamePlayScene+Extensions.swift
//
//  Created by MARK BROWNSWORD on 5/11/16.
//  Copyright © 2016 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

extension GamePlayScene {
    func entity<T>(ofType: T.Type, fromEntities: [GKEntity]) -> T? {
        var result: T? = nil
        
        for entity in fromEntities {
            if let entity = entity as? T {
                result = entity
                break
            }
        }
        
        return result
    }

    func system<T>(ofType: T.Type, from systems: [GKComponentSystem<GKComponent>]) -> T? {
        var result: T? = nil

        for system in systems {
            if let system = system as? T {
                result = system
                break
            }
        }

        return result
    }
    
    func findPath(from startCoordinate: int2, to endCoordinate: int2) -> [HexGraphNode] {
        let current = self.graph.node(atGridPosition: startCoordinate)
        let end = self.graph.node(atGridPosition: endCoordinate)
        
        return self.graph.findPath(from: current, to: end) as! [HexGraphNode]
    }

    func addEntity(entity: GKEntity, addNode: Bool = true) {
        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }

        self.entities.append(entity)

        if addNode, let visualEntity = entity as? VisualEntity {
            self.addChild(visualEntity.node)
        }
    }
}
