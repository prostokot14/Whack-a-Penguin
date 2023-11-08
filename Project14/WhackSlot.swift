//
//  WhackSlotNode.swift
//  Project14
//
//  Created by Антон Кашников on 08/11/2023.
//

import SpriteKit

final class WhackSlot: SKNode {
    private var charNode: SKSpriteNode!
    private var isVisible = false
    private var isHit = false
    
    func configure(at position: CGPoint) {
        self.position = position
        
        addChild(SKSpriteNode(imageNamed: "whackHole"))
        
        charNode = SKSpriteNode(imageNamed: "penguinGood")
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
        cropNode.addChild(charNode)
        
        addChild(cropNode)
    }
    
    func show(hideTime: Double) {
        if isVisible { return }
        
        charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
        
        isVisible = true
        isHit = false
        
        // One-third of the time the penguin will be good, the rest of the time it will be bad.
        if Int.random(in: 0...2) == 0 {
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        } else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + hideTime * 3.5) { [weak self] in
            self?.hide()
        }
    }
    
    func hide() {
        if !isVisible { return }
        
        charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
        isVisible = false
    }
}
