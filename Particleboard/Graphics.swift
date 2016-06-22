//
//  Graphics.swift
//  Barric's Tale
//
//  Created by Ryan Campbell on 3/27/15.
//  Copyright (c) 2015 Phalanx Studios. All rights reserved.
//

import SpriteKit

public enum UIUserInterfaceIdiom : Int {
    case Unspecified
    
    case Phone // iPhone and iPod touch style UI
    case Pad // iPad style UI
}

public class Graphics {
    
    
    // MARK: Effects
    
    public class func imageFadeOutAndRemove(img:SKNode, duration:TimeInterval) {
        img.run(SKAction.fadeOut(withDuration: duration), completion: {
            img.removeFromParent()
        })
    }
    
    public class func pulseBlendFactor(min:CGFloat, max:CGFloat, maxDelay:CGFloat, node:SKSpriteNode) {
        let intensity = CGFloat.random(min: min, max: max)
        let time = CGFloat.random(min: 0.1, max: maxDelay)
        let block = SKAction.run({
            node.colorBlendFactor = intensity
        })
        node.run(SKAction.sequence(
            [
                block,
                SKAction.wait(forDuration: Double(time))
            ])
        ) {
            Graphics.pulseBlendFactor(min: min, max: max, maxDelay: maxDelay, node: node)
        }
    }
    
    public class func pulseAlpha(min:CGFloat, max:CGFloat, maxDelay:CGFloat, node:SKNode) {
        let intensity = CGFloat.random(min: min, max: max)
        let time = CGFloat.random(min: 1, max: maxDelay)
        node.run(SKAction.fadeAlpha(to: intensity, duration: Double(time))) {
            Graphics.pulseAlpha(min: min, max: max, maxDelay: maxDelay, node: node)
        }
    }
    
    public class func pulseScale(min:CGFloat, max:CGFloat, maxDelay:CGFloat, node:SKNode) {
        let intensity = CGFloat.random(min: min, max: max)
        let time = CGFloat.random(min: 1, max: maxDelay)
        node.run(SKAction.scale(to: intensity, duration: Double(time))) {
            Graphics.pulseScale(min: min, max: max, maxDelay: maxDelay, node: node)
        }
    }
    
    public class func pulseScale(min:CGFloat, max:CGFloat, delay:CGFloat, node:SKNode) {
        let minAction = SKAction.scale(to: min, duration: Double(delay))
        let maxAction = SKAction.scale(to: max, duration: Double(delay))
        node.run(SKAction.repeatForever(SKAction.sequence([minAction, maxAction])))
    }
    
    // MARK: Loading
    
    public class func loadFramesFromAtlas(atlasNamed:String, baseFileName:String, numberOfFrames:Int) -> Array<SKTexture> {
        var frames = Array<SKTexture>()
        let atlas = SKTextureAtlas(named: atlasNamed)
        for index in 1...numberOfFrames {
            var fileName : String
            if(index < 10) {
                fileName = baseFileName + "0\(index)"
            }
            else {
                fileName = baseFileName + "\(index)"
            }
            frames.append(atlas.textureNamed(fileName))
        }
        return frames
    }
    
    public class func loadFramesFromAtlas(atlas:SKTextureAtlas, baseFileName:String, numberOfFrames:Int) -> Array<SKTexture> {
        var frames = Array<SKTexture>()
        for index in 1...numberOfFrames {
            var fileName : String
            if(index < 10) {
                fileName = baseFileName + "0\(index)"
            }
            else {
                fileName = baseFileName + "\(index)"
            }
            frames.append(atlas.textureNamed(fileName))
        }
        return frames
    }
    
    // MARK: Scene borders
    
    /// Note on functions below. Default scene coordinates:
    /// iphone: 0 to 2730
    /// ipad: 341 to 2389
    /// both have same viewable height
    public class func getLeftBound(sceneWidth:CGFloat = 2730) -> CGFloat {
        let rect = UIScreen.main().bounds
        
        // mainScreen.bounds always reports at half size. So in the default case, it would return 1365
        let halfScreen = rect.width
        
        // center of scene is sceneWidth / 2. Then subtract half of viewable area and you get far left coordinate.
        // On an iphone looking at default scene, it would be 0
        // On an ipad at default, it would be (2730 / 2) - 1024 = 1365 - 1024 = 341
        let leftBound = (sceneWidth / 2) - halfScreen
        if(leftBound == 341) {
            return 341
        }
        else {
            return 0
        }
    }
    
    public class func getRightBound(sceneWidth:CGFloat = 2730) -> CGFloat {
        let rect = UIScreen.main().bounds
        
        // mainScreen.bounds always reports at half size. So in the default case, it would return 1365
        let halfScreen = rect.width
        
        // center of scene is sceneWidth / 2. Then subtract half of viewable area and you get far left coordinate.
        // On an iphone looking at default scene, it would be 0
        // On an ipad at default, it would be (2730 / 2) + 1024 = 1365 + 1024 = 2389
        let rightBound = (sceneWidth / 2) + halfScreen
        if(rightBound == 2389) {
            return 2389
        }
        else {
            return 0
        }
    }
}
