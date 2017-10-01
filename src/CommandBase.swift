//
//  CommandBase.swift
//
//  Created by MARK BROWNSWORD on 18/2/17.
//  Copyright © 2017 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit

class CommandBase: NSObject, Command {

    // MARK: Public Properties

    var text: String!
    var execute: (() -> Void)!


    // MARK: Initialization

    init(text: String, execute: @escaping (() -> Void) = {_ in }) {
        self.text = text
        self.execute = execute
    }
}
