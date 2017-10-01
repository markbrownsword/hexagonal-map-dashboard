//
//  VisualEntity+Extensions.swift
//
//  Created by MARK BROWNSWORD on 23/1/17.
//  Copyright © 2017 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

extension VisualEntity {
    var isSelected: Bool {
        guard let component = self.component(ofType: SelectionComponent.self) else {
            return false
        }

        return component.selectionLocation != nil
    }
}
