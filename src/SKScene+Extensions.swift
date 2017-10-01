//
//  SKScene+Extensions.swift
//
//  Created by MARK BROWNSWORD on 10/9/17.
//  Copyright © 2017 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

extension SKScene {
    func initArchivedEntity(type: EntityType, name: String) -> VisualEntity {
        guard let archivedNode = self.childNode(withName: name) as? SKSpriteNode else {
            fatalError("Archived node not found")
        }

        return self.makeEntity(type: type, node: archivedNode)
    }

    func initEntity(type: EntityType, name: String, at position: CGPoint, imageNamed: String) -> VisualEntity {
        let node = self.makeNode(name: name, position: position, imageNamed: imageNamed)
        return self.makeEntity(type: type, node: node)
    }


    // Private functions
    
    private func makeNode(name: String, position: CGPoint, imageNamed image: String) -> SKSpriteNode {
        let texture = SKTexture(imageNamed: image)
        let size = texture.size()

        let node = SKSpriteNode(texture: texture, size: size)
        node.name = name
        node.position = position
        node.addChild(self.makeHealthIndicator(size: size, zPosition: CGFloat(node.children.count + 1)))

        return node
    }

    private func makeHealthIndicator(size: CGSize, zPosition: CGFloat) -> SKShapeNode {
        let circle = SKShapeNode(circleOfRadius: 10)
        circle.name = Constants.VisualEntityConstants.healthIndicatorName
        circle.position = CGPoint(x: size.width / 2, y: size.height / 2)
        circle.strokeColor = SKColor.black
        circle.glowWidth = 1.0
        circle.zPosition = zPosition

        return circle
    }

    private func makeEntity(type: EntityType, node: SKSpriteNode) -> VisualEntity {
        var result: VisualEntity

        switch type {
        case EntityType.rover:
            result = RoverEntity(node: node)
        case EntityType.none:
            fatalError("Unknown Entity Type")
        }
        
        return result
    }
}
