//
//  MoveComponent.swift
//
//  Created by MARK BROWNSWORD on 20/11/16.
//  Copyright © 2016 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

class MoveComponent: GKComponent {
    
    // MARK: Public Properties
    
    var updateRequired: Bool = false
    var node: SKSpriteNode!

    var actions: [SKAction]! {
        didSet {
            self.updateRequired = true
        }
    }
    
    
    // MARK: Initialization Functions
    
    required init(node: SKSpriteNode) {
        super.init()

        self.node = node
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
