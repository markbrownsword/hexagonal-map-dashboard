//
//  Command.swift
//
//  Created by MARK BROWNSWORD on 19/2/17.
//  Copyright © 2017 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit

protocol Command {
    var text: String! { get }
    var execute: (() -> Void)! { get }
}
