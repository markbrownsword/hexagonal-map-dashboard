//
//  GameSceneBase.swift
//
//  Created by MARK BROWNSWORD on 6/9/16.
//  Copyright © 2016 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameSceneBase : SKScene, TileMapScene, TileSelector {

    // MARK: GamePlayScene Properties

    private(set) var stateMachine: GKStateMachine!
    var graph: HexGraph<HexGraphNode>!
    var componentSystems: [GKComponentSystem<GKComponent>]!
    var entities: [GKEntity]!


    // MARK: TileMapScene Properties
    
    var backgroundLayer: SKTileMapNode!
    var gridLayer: SKTileMapNode!
    var selectionLayer: SKTileMapNode!
    var objectLayer: SKTileMapNode!


    // MARK: Properties

    var dash: Dashboard!
    var gameScene: SKScene! {
        return self
    }
    var gameDelegate: GameDelegate!


    // MARK: Private Properties

    private var lastUpdateTime: TimeInterval = 0
    
    
    // MARK: Override Functions
    
    override func didMove(to view: SKView) {
        guard let backgroundLayer = childNode(withName: "background") as? SKTileMapNode else {
            fatalError("Background node not loaded")
        }

        guard let gridLayer = childNode(withName: "grid") as? SKTileMapNode else {
            fatalError("Grid node not loaded")
        }

        guard let selectionLayer = childNode(withName: "selection") as? SKTileMapNode else {
            fatalError("Selection node not loaded")
        }

        guard let objectLayer = childNode(withName: "object") as? SKTileMapNode else {
            fatalError("Object node not loaded")
        }

        guard let camera = self.childNode(withName: "gameCamera") as? SKCameraNode else {
            fatalError("Camera node not loaded")
        }

        guard let view = self.view else {
            fatalError("View not available")
        }

        // Initialise Camera
        camera.updateScale()
        camera.updateConstraints(backgroundLayer: backgroundLayer, viewBounds: view.bounds)

        // Link Scene variables
        self.backgroundLayer = backgroundLayer
        self.gridLayer = gridLayer
        self.selectionLayer = selectionLayer
        self.objectLayer = objectLayer
        self.camera = camera

        // Initialise the Scene State Machine
        self.stateMachine = GKStateMachine(states: [
            PlayerTurn(tileMapScene: self),
            OpponentTurn(tileMapScene: self),
            GamePaused(tileMapScene: self),
            GameOver(tileMapScene: self)
        ])

        // Setup GridLayer
        self.floodFillGrid()

        // Invoke GameplayScene Template Functions
        self.setupGraph()
        self.setupComponentSystems()
        self.setupEntities()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Initialize _lastUpdateTime if it has not already been done
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime

        // Update State Machine
        self.stateMachine.update(deltaTime: dt)

        // Set CurrentTime
        self.lastUpdateTime = currentTime
    }


    // MARK: Archive Functions

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)

        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground), name: .UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: .UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: .UIApplicationWillResignActive, object: nil)
    }

    override func encode(with encoder: NSCoder) {
        super.encode(with: encoder)
    }


    // MARK: UIApplication Observer Functions

    func applicationDidEnterBackground() {
        self.gameDelegate.saveScene(gameFolder: "MarsGameScene", scene: self)
    }

    func applicationDidBecomeActive() {
        self.setupDash()
        self.stateMachine.enter(PlayerTurn.self)
    }

    func applicationWillResignActive() {
        self.stateMachine.enter(GamePaused.self)
    }

    
    // MARK: GameplayScene Functions

    func setupGraph() {
        fatalError("Abstract function must be overridden")
    }

    func setupComponentSystems() {
        fatalError("Abstract function must be overridden")
    }

    func setupEntities() {
        fatalError("Abstract function must be overridden")
    }

    func archiveEntities() {
        fatalError("Abstract function must be overridden")
    }


    // MARK: TilemapScene Functions

    func setupDash() {
        fatalError("Abstract function must be overridden")
    }
}
