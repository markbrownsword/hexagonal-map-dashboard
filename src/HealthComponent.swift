//
//  HealthComponent.swift
//
//  Created by MARK BROWNSWORD on 16/10/16.
//  Copyright © 2016 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

class HealthComponent: GKComponent {

    // MARK: Public Properties
    
    var updateRequired: Bool = false
    var node: SKSpriteNode!
    var data: Int = 100 {
        didSet {
            self.updateRequired = true
        }
    }
    
    
    // MARK: Initialization Functions
    
    required init(node: SKSpriteNode) {
        super.init()
        
        self.updateRequired = true
        self.node = node
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
