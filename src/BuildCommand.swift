//
//  BuildCommand.swift
//
//  Created by MARK BROWNSWORD on 26/3/17.
//  Copyright © 2017 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit

class BuildCommand: CommandBase {
    init(execute: @escaping (() -> Void) = {_ in }) {
        super.init(text: "BUILD", execute: execute)
    }
}
