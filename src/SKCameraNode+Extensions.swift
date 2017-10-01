//
//  SKCameraNode+Extensions.swift
//
//  Created by MARK BROWNSWORD on 16/8/16.
//  Copyright © 2016 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

extension SKCameraNode {
    func updateScale() {
        self.setScale(1.75)
    }

    func updateConstraints(backgroundLayer: SKTileMapNode, viewBounds: CGRect) {
        let xInset = min(viewBounds.width / 2 * self.xScale, backgroundLayer.frame.width / 2)
        let yInset = min(viewBounds.height / 2 * self.yScale, backgroundLayer.frame.height / 2)
        let constraintRect = backgroundLayer.frame.insetBy(dx: xInset, dy: yInset)

        let xRange = SKRange(lowerLimit: constraintRect.minX, upperLimit: constraintRect.maxX)
        let yRange = SKRange(lowerLimit: constraintRect.minY, upperLimit: constraintRect.maxY)

        let edgeConstraint = SKConstraint.positionX(xRange, y: yRange)
        edgeConstraint.referenceNode = backgroundLayer

        // Adjust camera position (if it is outside boundary)
        self.updateBoundaryPosition(x: xRange, y: yRange)

        // Apply constraints to the camera
        self.constraints = [edgeConstraint]
    }

    func pan(to visualEntity: VisualEntity) {
        let deltaX = self.position.x - visualEntity.node.position.x
        let deltaY = self.position.y - visualEntity.node.position.y

        let distance = sqrt(pow(deltaX, 2) + pow(deltaY, 2))
        let speed: CGFloat = 400
        let duration = TimeInterval(distance / speed)

        let moveAction = SKAction.move(to: visualEntity.node.position, duration: duration)
        moveAction.timingMode = .easeOut

        self.run(moveAction)
    }


    // MARK: Private functions

    private func updateBoundaryPosition(x: SKRange, y: SKRange) {
        if (self.position.x < x.lowerLimit) {
            self.position.x = x.lowerLimit
        } else if (self.position.x > x.upperLimit) {
            self.position.x = x.upperLimit
        }

        if (self.position.y < y.lowerLimit) {
            self.position.y = y.lowerLimit
        } else if (self.position.y > y.upperLimit) {
            self.position.y = y.upperLimit
        }
    }
}
