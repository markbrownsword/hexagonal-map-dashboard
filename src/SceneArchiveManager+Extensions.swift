//
//  SceneArchiveManager+Extensions.swift
//  SpaceGame
//
//  Created by MARK BROWNSWORD on 30/9/17.
//  Copyright © 2017 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

extension SceneArchiveManager {
    func saveScene(gameFolder folder: String, scene: GamePlayScene) {
        guard let folderURL = self.libraryFolderURL?.appendingPathComponent(folder) else {
            return
        }

        let fileURL = folderURL.appendingPathComponent(self.file)

        do {
            try FileManager.default.createDirectory(atPath: folderURL.path, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print("Failed to create directory: \(error.debugDescription)")
            return
        }

        scene.archiveEntities()
        NSKeyedArchiver.archiveRootObject(scene, toFile: fileURL.path)
    }

    func loadScene(gameFolder folder: String) -> TileMapScene! {
        guard let folderURL = self.libraryFolderURL?.appendingPathComponent(folder) else {
            fatalError("Couldn't create folder")
        }

        let fileURL = folderURL.appendingPathComponent(self.file)
        let tileMapScene: TileMapScene

        if FileManager.default.fileExists(atPath: fileURL.path) {
            tileMapScene = NSKeyedUnarchiver.unarchiveObject(withFile: fileURL.path) as! TileMapScene
            _ = try? FileManager.default.removeItem(at: fileURL)
        } else {
            guard let scene = GKScene(fileNamed: folder) else {
                fatalError("Couldn't load scene")
            }
            tileMapScene = scene.rootNode as! TileMapScene
        }

        return tileMapScene
    }
}
