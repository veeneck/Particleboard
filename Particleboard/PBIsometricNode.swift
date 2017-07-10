//
//  PBIsometricNode.swift
//  Particleboard
//
//  Created by Ryan Campbell on 7/10/17.
//  Copyright © 2017 Phalanx Studios. All rights reserved.
//

import SpriteKit

public class PBIsometricNode : SKTransformNode {
    
    public override init() {
        super.init()
        self.setEulerAngles(vector_float3(x:120, y:0, z:0))
        self.zPosition = 1
        self.position = CGPoint(x:0, y:0)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func addChild(_ node: SKNode) {
        node.position = CGPoint(x:node.position.x, y:node.position.y / (1.414213562373095 * 0.577))
        super.addChild(node)
    }
    
}
