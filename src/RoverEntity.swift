//
//  RoverEntity.swift
//
//  Created by MARK BROWNSWORD on 13/10/16.
//  Copyright © 2016 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

class RoverEntity : VisualEntityBase {

    // MARK: Initialization
    
    init(node: SKSpriteNode) {
        super.init(type: EntityType.rover, node: node, healthIndicator: node.childNode(withName: Constants.VisualEntityConstants.healthIndicatorName) as! SKShapeNode)

        self.addComponents()
    }


    // MARK: Archive Functions
    
    required init?(coder decoder: NSCoder) {
        fatalError("Not implemented")
    }
  

    // MARK: Private Functions

    private func addComponents() {
        self.addComponent(HealthComponent(node: self.node))
        self.addComponent(MoveComponent(node: self.node))
        self.addComponent(SelectionComponent(node: self.node))
    }
}
