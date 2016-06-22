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
public extension SKCameraNode {
    
    /// Use this to move camera around manually.
    public func panToPoint(point:CGPoint, duration:Double = 0.3) {
        self.run(SKAction.move(to: point, duration: duration))
    }
    
}
