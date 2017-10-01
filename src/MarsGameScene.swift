//
//  MarsGameScene.swift
//
//  Created by MARK BROWNSWORD on 24/7/16.
//  Copyright © 2016 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

class MarsGameScene: GameSceneBase {

    // MARK: Private Declarations

    private enum TouchState { case none, tap, pan }

    
    // MARK: Private Properties

    private var healthSystem: HealthSystem!
    private var moveSystem: MoveSystem!
    private var selectionSystem: SelectionSystem!
    private var touchState: TouchState = .none


    // MARK: Archive Properties

    private let entitiesKey = "entities"

    
    // MARK: GamePlayScene Members

    override func setupGraph() {
        let nodes = buildGraphNodes()
        
        self.graph = HexGraph(nodes)
        self.graph.connectAdjacentNodes()
    }
    
    override func setupComponentSystems() {
        self.healthSystem = HealthSystem()
        self.healthSystem.delegate = self

        self.moveSystem = MoveSystem()
        self.moveSystem.delegate = self

        self.selectionSystem = SelectionSystem()
        self.selectionSystem.delegate = self

        self.componentSystems = [
            self.healthSystem,
            self.moveSystem,
            self.selectionSystem
        ]
    }

    override func setupEntities() {
        self.entities = []

        // New Game
        guard let entities = self.userData?.object(forKey: self.entitiesKey) else {
            let mapCoordinate = self.mapCoordinate(from: CGPoint(x: -265, y: -50))
            let position = self.backgroundLayer.centerOfTile(atColumn: Int(mapCoordinate.x), row: Int(mapCoordinate.y))
            let entity = self.initEntity(type: EntityType.rover, name: "Rover", at: position, imageNamed: "Rover") as! GKEntity
            self.addEntity(entity: entity) // Add default entity
            return
        }

        // Reload Archived Game
        for meta in entities as! [EntityMeta] {
            let entity = self.initArchivedEntity(type: meta.type, name: meta.name) as! GKEntity
            self.addEntity(entity: entity, addNode: false)
            
            // Set entity selection status, if selectionLayer tile exists
            if let visualEntity = entity as? VisualEntity, self.selectionLayer.exists(at: visualEntity.node.position) {
                self.selectionSystem.process(entity: visualEntity, input: visualEntity.node.position)
            }
        }
    }

    override func archiveEntities() {
        var meta = [EntityMeta]()
        for entity in self.entities {
            guard let visualEntity = entity as? VisualEntity else {
                continue
            }

            let entityMeta = EntityMeta(name: visualEntity.name, type: visualEntity.type)
            meta.append(entityMeta)
        }

        self.userData = NSMutableDictionary()
        self.userData?.setObject(meta, forKey: self.entitiesKey as NSCopying)
    }


    // MARK: TileMapScene Functions

    override func setupDash() {
        if self.dash == nil {
            guard let camera = self.camera, let scene = scene else {
                fatalError("Camera not found")
            }
            
            let dashboardName = "dashboard"
            if let dash = camera.childNode(withName: dashboardName) as? Dashboard {
                self.dash = dash
            } else {
                self.dash = Dashboard(displayRect: scene.frame)
                self.dash.name = dashboardName
                camera.addChild(self.dash)
            }
        }

        self.dash.addCommandButtons()
        self.dash.delegate = self
        self.dash.ready = true
    }
    
    
    // MARK: Touch Handling functions

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchState = .tap
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let camera = self.camera else {
            return
        }

        let targetLocation = touch.location(in: self)
        let previousLocation = touch.previousLocation(in: self)

        let translation = CGPoint(x: targetLocation.x - previousLocation.x, y: targetLocation.y - previousLocation.y)
        if translation == CGPoint.zero {
            return
        }

        camera.position.x -= translation.x
        camera.position.y -= translation.y

        self.touchState = .pan
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.touchState == .tap {
            guard let touch = touches.first else { return }
            let targetLocation = touch.location(in: self)

            if !self.isMapTile(at: targetLocation) {
                self.touchState = .none
                return
            }

            if self.isObstacle(at: targetLocation) {
                self.touchState = .none
                return
            }
            
            if let visualEntity = self.findEntity(at: targetLocation) {
                if visualEntity.stateMachine.canEnterState(VisualEntityPendingMove.self) {
                    // Toggle selection on / off
                    self.selectionSystem.process(entity: visualEntity, input: visualEntity.isSelected ? nil : targetLocation)
                }
            } else if let visualEntity = self.selectionSystem.selectedEntity {
                // Toggle selection off
                self.selectionSystem.process(entity: visualEntity, input: nil)
                
                // Invoke move system
                self.moveSystem.process(entity: visualEntity, input: targetLocation)
            }
        }

        self.touchState = .none
    }
}
