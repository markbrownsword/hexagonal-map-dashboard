//
//  VisualEntityBase.swift
//
//  Created by MARK BROWNSWORD on 13/10/16.
//  Copyright © 2016 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

class VisualEntityBase : GKEntity, VisualEntity {
    

    // MARK: Public Properties

    weak var delegate: GamePlayScene!

    private(set) var type: EntityType!
    private(set) var node: SKSpriteNode!
    private(set) var name: String!
    private(set) var healthIndicator: SKShapeNode!
    private(set) var stateMachine: GKStateMachine!

    
    // MARK: Initialization
    
    init(type: EntityType, node: SKSpriteNode, healthIndicator: SKShapeNode) {
        super.init()

        // Initialise Type
        self.type = type

        // Initialise Name
        self.name = node.name
        
        // Initialise Nodes
        self.node = node
        self.healthIndicator = healthIndicator

        // Initialise state machine
        self.stateMachine = GKStateMachine(states: [
            VisualEntityIdle(),
            VisualEntityPendingMove(),
            VisualEntityMoving()
        ])
        self.stateMachine.enter(VisualEntityIdle.self)
    }


    // MARK: Archive Functions

    required init?(coder decoder: NSCoder) {
        fatalError("Not implemented")
    }
}
