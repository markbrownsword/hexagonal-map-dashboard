//
//  SceneArchiveManager.swift
//
//  Created by MARK BROWNSWORD on 30/9/17.
//  Copyright © 2017 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol SceneArchiveManager: class {
    var file: String { get }
    var libraryFolderURL: URL? { get }
}
