//
//  SKCameraNode+Extensions.swift
//  With War & Woe
//
//  Created by Ryan Campbell on 8/5/15.
//  Copyright © 2015 Ryan Campbell. All rights reserved.
//

import SpriteKit

/**
    Helpful extensions to encapsulate common camera actions in case the logic becomes more complex over time.
*/

/// Register BG's to move with the camera. Node is the BG, CGFloat is the speed from camera
public var GLOBAL_PARALLAX_BACKGROUND = Dictionary<SKNode, CGFloat>()

public extension SKCameraNode {
    
    /// Use this to move camera around manually.
    public func panToPoint(point:CGPoint, duration:Double = 0.3) {
        self.run(SKAction.move(to: point, duration: duration))
    }
    
    public func shake(duration:Float) {
        let amplitudeX:Float = 10
        let amplitudeY:Float = 6
        let numberOfShakes = duration / 0.04
        var actionsArray = [SKAction]()
        for _ in 1...Int(numberOfShakes) {
            // build a new random shake and add it to the list
            let moveX = Float(arc4random_uniform(UInt32(amplitudeX))) - amplitudeX / 2
            let moveY = Float(arc4random_uniform(UInt32(amplitudeY))) - amplitudeY / 2
            let shakeAction = SKAction.moveBy(x: CGFloat(moveX), y: CGFloat(moveY), duration: 0.02)
            shakeAction.timingMode = SKActionTimingMode.easeOut
            actionsArray.append(shakeAction)
            actionsArray.append(shakeAction.reversed())
        }
        
        let actionSeq = SKAction.sequence(actionsArray)
        self.run(actionSeq)
    }
    
    override open var position : CGPoint {
        didSet {
            for (node, speed) in GLOBAL_PARALLAX_BACKGROUND {
                let offsetX = position.x - oldValue.x
                let offsetY = position.y - oldValue.y
                let changeX = offsetX * speed
                let changeY = offsetY * speed
                node.position = CGPoint(x:node.position.x + changeX, y:node.position.y+changeY)
            }
        }
    }
    
}
