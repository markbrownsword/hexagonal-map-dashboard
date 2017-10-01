//
//  GameViewController.swift
//
//  Created by MARK BROWNSWORD on 24/7/16.
//  Copyright © 2016 MARK BROWNSWORD. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, GameDelegate, SceneArchiveManager {

    // MARK: SceneArchiveManager Properties

    var file: String {
        return "current-game"
    }

    lazy var libraryFolderURL: URL? = {
        guard let directory = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first else {
            return nil
        }

        return directory.appendingPathComponent("Archive")
    }()
    
    
    // MARK: Property Overrides
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    // MARK: Function overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let view = self.view as! SKView? else {
            fatalError("View not loaded")
        }
        
        guard let sceneNode = self.loadScene(gameFolder: "MarsGameScene") else {
            fatalError("Scene not loaded")
        }
        
        sceneNode.scaleMode = .resizeFill
        sceneNode.gameDelegate = self
        
        view.presentScene(sceneNode.gameScene)
        view.ignoresSiblingOrder = true

#if DEBUG
        view.showsFPS = true
        view.showsNodeCount = true
#endif
    }
}
