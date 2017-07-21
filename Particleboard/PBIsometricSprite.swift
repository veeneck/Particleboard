//
//  PBIsometricSprite.swift
//  Particleboard
//
//  Created by Ryan Campbell on 7/20/17.
//  Copyright © 2017 Phalanx Studios. All rights reserved.
//

import SpriteKit

public class PBIsometricSprite : SKSpriteNode {
    
    override public var position : CGPoint {
        didSet {
            super.position = CGPoint(x:position.x, y:(position.y / (1.414213562373095 * 0.577)))
        }
    }
    
}

public class PBIsometricEmitter : SKEmitterNode {
    
    override public var position : CGPoint {
        didSet {
            super.position = CGPoint(x:position.x, y:(position.y / (1.414213562373095 * 0.577)))
        }
    }
    
}
