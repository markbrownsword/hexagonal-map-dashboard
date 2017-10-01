//
//  Dashboard.swift
//
//  Created by MARK BROWNSWORD on 12/2/17.
//  Copyright © 2017 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit

class Dashboard: SKNode {

    // MARK: Public Properties

    weak var delegate: TileMapScene!
    var ready: Bool = false


    // MARK: Private Properties

    private var displayRect: CGRect!
    private var buttonContainer: SKNode!


    // MARK: Private Constants

    private let buttonContainerName = "buttonContainer"
    private let displayRectName = "displayRect"


    // MARK: Initialisation

    init(displayRect: CGRect) {
        super.init()

        self.displayRect = displayRect

        self.buttonContainer = SKNode()
        self.buttonContainer.name = buttonContainerName

        self.addChild(self.buttonContainer)
    }


    // MARK: Archive Functions

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)

        self.displayRect = decoder.decodeObject(forKey: self.displayRectName) as! CGRect
        self.buttonContainer = self.childNode(withName: self.buttonContainerName)
    }

    override func encode(with encoder: NSCoder) {
        self.removeCommandButtons()
        self.ready = false

        encoder.encode(self.displayRect, forKey: self.displayRectName)
        super.encode(with: encoder)
    }


    // MARK: Public Functions

    func addCommandButtons() {
        if self.buttonContainer.children.count > 0 {
            return
        }
        
        let buttons = self.systemCommands()
        for button in buttons {
            self.buttonContainer.addChild(button)
        }
    }
    
    func removeCommandButtons() {
        let buttons = self.buttonContainer.children
        for button in buttons {
            guard let button = button as? CommandButton else {
                continue
            }
            
            button.removeFromParent()
        }
    }
        
    func disableCommandButtons() {
        self.toggleButtonsEnabled(enable: false)
    }

    func enableCommandButtons() {
        self.toggleButtonsEnabled(enable: true)
    }


    // MARK: Private Functions

    private func toggleButtonsEnabled(enable: Bool) {
        let buttons = self.buttonContainer.children
        for button in buttons {
            guard let button = button as? CommandButton else {
                continue
            }

            button.enabled = enable
        }
    }

    private func systemCommands() -> [CommandButton] {
        // Button size
        let buttonWidth = 120
        let buttonHeight = 50
        let size = CGSize(width: buttonWidth, height: buttonHeight)

        // Button Position
        let buttonPosX = self.displayRect.size.width / 2
        let buttonPosY = -self.displayRect.size.height / 2 + CGFloat(50)
        let buttonMargin = CGFloat(100)

        // Init Build Button
        let buildButtonPosX = -buttonPosX + buttonMargin
        let buildCommand = BuildCommand(execute: self.handleBuildCommand)
        let buildButton = CommandButton(size: size, text: buildCommand.text, command: buildCommand)
        buildButton.position = CGPoint(x: buildButtonPosX, y: buttonPosY)
        buildButton.enabled = false

        // Init Next Turn Button
        let turnButtonPosX = buttonPosX - buttonMargin
        let turnCommand = TurnCommand(execute: self.handleMoveCommand)
        let turnButton = CommandButton(size: size, text: turnCommand.text, command: turnCommand)
        turnButton.position = CGPoint(x: turnButtonPosX, y: buttonPosY)
        turnButton.enabled = false

        return [buildButton, turnButton]
    }

    private func handleMoveCommand() {
        print("TODO: Next Turn!!!")
    }

    private func handleBuildCommand() {
        print("TODO: Display build commands!!!")
    }
}
