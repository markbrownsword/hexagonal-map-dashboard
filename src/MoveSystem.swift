//
//  MoveSystem.swift
//
//  Created by MARK BROWNSWORD on 20/11/16.
//  Copyright © 2016 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

class MoveSystem: GKComponentSystem<GKComponent> {
    
    // MARK: Public Properties
    
    weak var delegate: TileMapScene!
    
    
    // MARK: Initialisation
    
    override required init() {
        super.init(componentClass: MoveComponent.self)
    }
    
    
    // MARK: ComponentSystem Functions
    
    func process(entity: VisualEntity, input: CGPoint) {
        guard let healthSystem = self.delegate.system(ofType: HealthSystem.self, from: self.delegate.componentSystems) else {
            return
        }

        guard let moveComponent = entity.component(ofType: MoveComponent.self) else {
            return
        }

        entity.stateMachine.enter(VisualEntityPendingMove.self)

        let startCoordinate = self.delegate.mapCoordinate(from: entity.node.position)
        let endCoordinate = self.delegate.mapCoordinate(from: input)
        let path = self.delegate.findPath(from: startCoordinate, to: endCoordinate)

        var sequence = [SKAction]()
        for node in path.dropFirst() {
            let location = self.delegate.backgroundLayer.centerOfTile(atColumn: Int(node.gridPosition.x), row: Int(node.gridPosition.y))
            let action = SKAction.move(to: location, duration: 1)
            let completionHandler = SKAction.run({
                healthSystem.process(entity: entity, input: Int(node.costToEnter))
            })
            
            sequence += [action, completionHandler]
        }

        sequence.insert(SKAction.run({ entity.stateMachine.enter(VisualEntityMoving.self) }), at: 0) // Add at beginning
        sequence.append(SKAction.run({ entity.stateMachine.enter(VisualEntityIdle.self) })) // Add at end

        moveComponent.actions = sequence
    }


    // MARK: Override Functions

    override func update(deltaTime seconds: TimeInterval) {
        for component in (self.components as? [MoveComponent])! {
            if !component.updateRequired {
                continue
            }

            component.node.run(SKAction.sequence(component.actions))
            component.updateRequired = false
        }
    }
}
