//
//  SelectionSystem.swift
//
//  Created by MARK BROWNSWORD on 19/1/17.
//  Copyright © 2017 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit
import GameplayKit

class SelectionSystem: GKComponentSystem<GKComponent> {

    // MARK: Public Properties

    weak var delegate: TileSelector!


    // MARK: Initialisation

    override required init() {
        super.init(componentClass: SelectionComponent.self)
    }


    // MARK: ComponentSystem Functions

    func process(entity: VisualEntity, input: CGPoint?) {
        guard let component = entity.component(ofType: SelectionComponent.self) else {
            return
        }

        // Toggle selectionLocation
        component.selectionLocation = component.selectionLocation == nil ? input : nil
    }
    
    var selectedEntity: VisualEntity? {
        for component in (self.components as? [SelectionComponent])! {
            if component.entity as? VisualEntity == nil || component.selectionLocation == nil {
                continue
            }
            
            return (component.entity as! VisualEntity)
        }
        
        return nil
    }


    // MARK: Override Functions

    override func update(deltaTime seconds: TimeInterval) {
        for component in (self.components as? [SelectionComponent])! {
            if !component.updateRequired {
                continue
            }

            if component.selectionLocation == nil {
                self.delegate.removeSelection()
            } else {
                self.delegate.addSelection(at: component.selectionLocation!)
            }

            component.updateRequired = false
        }
    }
}
