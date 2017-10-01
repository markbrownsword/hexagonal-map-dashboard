//
//  HealthSystem.swift
//
//  Created by MARK BROWNSWORD on 31/10/16.
//  Copyright © 2016 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

class HealthSystem: GKComponentSystem<GKComponent> {

    // MARK: Public Properties
    
    weak var delegate: TileMapScene!
    
    
    // MARK: Initialisation
    
    override required init() {
        super.init(componentClass: HealthComponent.self)
    }
    
    
    // MARK: ComponentSystem Functions
    
    func process(entity: VisualEntity, input: Int) {
        guard let healthComponent = entity.component(ofType: HealthComponent.self) else {
            return
        }

        healthComponent.data -= input
    }


    // MARK: Override Functions

    override func update(deltaTime seconds: TimeInterval) {
        for component in (self.components as? [HealthComponent])! {
            if !component.updateRequired {
                continue
            }

            guard let entity = component.entity as? VisualEntity else {
                continue
            }
            
            entity.healthIndicator.fillColor = GetCircleColour(health: component.data)
            component.updateRequired = false
        }
    }


    // MARK: Private Functions

    private func GetCircleColour(health: Int) -> SKColor {
        var result: SKColor
        switch health {
        case 50...100:
            result = SKColor.green
        case 25..<50:
            result = SKColor.orange
        default:
            result = SKColor.red
        }

        return result
    }
}
