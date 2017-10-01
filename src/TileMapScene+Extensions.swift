//
//  TileMapScene+Extensions.swift
//
//  Created by MARK BROWNSWORD on 5/9/16.
//  Copyright © 2016 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit

extension TileMapScene {
    
    // MARK: Grid Tile Properties
    
    var gridTile: SKTileGroup {
        guard let selectionTile = self.gridLayer.tileSet.tileGroups.first(where: {$0.name == "Tiles"}) else {
            fatalError("Grid tile not found")
        }
        
        return selectionTile
    }
    
    var gridTileDefinition: SKTileDefinition {
        guard let gridTileSetRule = self.gridTile.rules.first(where: {$0.name == "Tile"}) else {
            fatalError("Grid tileset rule not found")
        }
        
        guard let gridTileDefinition = gridTileSetRule.tileDefinitions.first(where: {$0.name == "Grid"}) else {
            fatalError("Grid tile definition not found")
        }
        
        return gridTileDefinition
    }
    
    
    // MARK: Selection Tile Properties
    
    var selectionTile: SKTileGroup {
        guard let selectionTile = self.selectionLayer.tileSet.tileGroups.first(where: {$0.name == "Tiles"}) else {
            fatalError("Selection tile not found")
        }
        
        return selectionTile
    }
    
    var selectionTileDefinition: SKTileDefinition {
        guard let selectionTileSetRule = self.selectionTile.rules.first(where: {$0.name == "Tile"}) else {
            fatalError("Tileset rule not found")
        }
        
        guard let selectionTileDefinition = selectionTileSetRule.tileDefinitions.first(where: {$0.name == "Selection"}) else {
            fatalError("Tile definition not found")
        }
        
        return selectionTileDefinition
    }
    
    
    // MARK: Base Tile Properties
    
    var baseTile: SKTileGroup {
        guard let baseTile = self.objectLayer.tileSet.tileGroups.first(where: {$0.name == "Tiles"}) else {
            fatalError("Objects TileSet not found")
        }
        
        return baseTile
    }
    
    var baseTileDefinition: SKTileDefinition {
        guard let baseTileSetRule = self.baseTile.rules.first(where: {$0.name == "Tile"}) else {
            fatalError("Tileset rule not found")
        }
        
        guard let baseTileDefinition = baseTileSetRule.tileDefinitions.first(where: {$0.name == "Base"}) else {
            fatalError("Tile definition not found")
        }
        
        return baseTileDefinition
    }
    
    
    // MARK: TileSelector Functions
    
    func addSelection(at targetLocation: CGPoint) {
        let newColumn = self.selectionLayer.tileColumnIndex(fromPosition: targetLocation)
        let newRow = self.selectionLayer.tileRowIndex(fromPosition: targetLocation)

        // Add selection tile to map at specified column and row
        self.selectionLayer.setTileGroup(self.selectionTile, andTileDefinition: self.selectionTileDefinition, forColumn: newColumn, row: newRow)
    }

    func removeSelection() {
        self.selectionLayer.fill(with: nil)
    }
    
    
    // MARK: Functions
    
    func floodFillGrid() {
        self.gridLayer.fill(with: self.gridTile)
    }
    
    func mapCoordinate(from position: CGPoint) -> int2 {
        let startColumn = self.backgroundLayer.tileColumnIndex(fromPosition: position)
        let startRow = self.backgroundLayer.tileRowIndex(fromPosition: position)
        
        return int2(x: Int32(startColumn), y: Int32(startRow))
    }

    func isObstacle(at targetLocation: CGPoint) -> Bool {
        let isObstacle = self.backgroundLayer.getUserData(forKey: "isObstacle", location: targetLocation) as! Bool

        return isObstacle
    }

    func isObstacle(at column: Int, row: Int) -> Bool {
        let isObstacle = self.backgroundLayer.getUserData(forKey: "isObstacle", column: column, row: row) as! Bool

        return isObstacle
    }

    func costToEnter(tile column: Int, row: Int) -> Float {
        let costToEnter = self.backgroundLayer.getUserData(forKey: "costToEnter", column: column, row: row) as! Float

        return costToEnter
    }

    func isEntity(visualEntity: VisualEntity, at targetLocation: CGPoint?) -> Bool {
        if targetLocation == nil {
            return false
        }

        return self.backgroundLayer.atSameMapTile(visualEntity.node.position, and: targetLocation!)
    }

    func isMapTile(at targetLocation: CGPoint) -> Bool {
        return self.backgroundLayer.exists(at: targetLocation)
    }
    
    func findEntity(at targetLocation: CGPoint) -> VisualEntity? {
        for entity in self.entities {
            guard let visualEntity = entity as? VisualEntity else {
                continue
            }
            
            if self.isEntity(visualEntity: visualEntity, at: targetLocation) {
                return visualEntity
            }
        }
        
        return nil
    }

    func buildGraphNodes() -> [HexGraphNode] {
        var nodes = [HexGraphNode]()

        for column in 0 ..< self.backgroundLayer.numberOfColumns {
            for row in 0 ..< self.backgroundLayer.numberOfRows {
                if self.isObstacle(at: column, row: row) {
                    continue
                }

                let position = vector_int2(x: Int32(column), y: Int32(row))
                let costToEnter = self.costToEnter(tile: column, row: row)
                nodes.append(HexGraphNode(gridPosition: position, costToEnter: costToEnter))
            }
        }

        return nodes
    }
}
