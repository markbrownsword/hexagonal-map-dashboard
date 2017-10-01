//
//  SelectionComponent.swift
//
//  Created by MARK BROWNSWORD on 18/1/17.
//  Copyright © 2017 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

class SelectionComponent: GKComponent {

    // MARK: Public Properties

    var updateRequired: Bool = false
    var node: SKSpriteNode!
    var selectionLocation: CGPoint? {
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
