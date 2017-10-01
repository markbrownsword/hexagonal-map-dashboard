//
//  EntityMeta.swift
//
//  Created by MARK BROWNSWORD on 5/3/17.
//  Copyright © 2017 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit

class EntityMeta: NSObject, NSCoding {

    // MARK: Public Properties

    var name: String
    var type: EntityType = .none


    // MARK: Encoding Properties

    private let nameKey: String! = "EntityMeta.name"
    private let typeKey: String! = "EntityMeta.type"


    // MARK: Initialisation

    init(name: String, type: EntityType) {
        self.name = name
        self.type = type
    }

    required init?(coder decoder: NSCoder) {
        self.name = (decoder.decodeObject(forKey: self.nameKey) as? String)!
        
        let savedType = decoder.decodeInteger(forKey: self.typeKey)
        if let type = EntityType(rawValue: savedType) {
            self.type = type
        }

        super.init()
    }

    func encode(with encoder: NSCoder) {
        encoder.encode(self.name, forKey: self.nameKey)
        encoder.encode(self.type.rawValue, forKey: self.typeKey)
    }
}
