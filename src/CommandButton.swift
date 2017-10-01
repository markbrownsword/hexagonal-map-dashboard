//
//  CommandButton.swift
//
//  Created by MARK BROWNSWORD on 7/2/17.
//  Copyright © 2017 MARK BROWNSWORD. All rights reserved.
//

import SpriteKit

class CommandButton: SKNode {

    // MARK: Private Declarations

    private var main: SKSpriteNode!
    private var border: SKSpriteNode!
    private var label: SKLabelNode!
    private var command: Command!


    // MARK: Private Constants

    private let borderName = "CommandButton.border"
    private let mainName = "CommandButton.main"
    private let labelName = "CommandButton.label"

    private let touchDelay: TimeInterval = 0.25
    private let buttonBorder: CGFloat = 5
    private let normalAlpha: CGFloat = 0.75
    private let touchedAlpha: CGFloat = 1.0


    // MARK: Public Declarations

    var enabled: Bool = true {
        didSet {
            self.label.alpha = self.enabled ? 1.0 : 0.5
        }
    }

    init(size: CGSize, text: String, command: Command) {
        super.init()

        self.main = SKSpriteNode(color: .black, size: CGSize(width: size.width - buttonBorder, height: size.height - buttonBorder))
        self.main.name = self.mainName
        self.main.alpha = normalAlpha
        
        self.border = SKSpriteNode(color: .white, size: size)
        self.border.name = self.borderName
        self.border.alpha = normalAlpha

        self.label = SKLabelNode(fontNamed: "Verdana")
        self.label.name = self.labelName
        self.label.text = text
        self.label.fontSize = 22
        self.label.fontColor = .white
        self.label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center;
        self.label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center;

        self.command = command

        self.isUserInteractionEnabled = true
        self.addChild(self.border)
        self.addChild(self.main)
        self.addChild(self.label)
    }


    // MARK: Archive Functions

    required init?(coder decoder: NSCoder) {
        fatalError("Not implemented")
    }


    // MARK: Touch Functions

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.border.alpha = touchedAlpha
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.run(SKAction.wait(forDuration: touchDelay), completion: {
            guard let touch = touches.first else { return }
            let location = touch.location(in: self)

            if self.main.contains(location) {
                self.command.execute()
            }

            self.border.alpha = self.normalAlpha
        })
    }
}
