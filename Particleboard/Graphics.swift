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
        /*let intensity = CGFloat.random(min: min, max: max)
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
        }*/
    }
    
    public class func pulseAlpha(min:CGFloat, max:CGFloat, maxDelay:CGFloat, node:SKNode) {
        /*let intensity = CGFloat.random(min: min, max: max)
        let time = CGFloat.random(min: 1, max: maxDelay)
        node.run(SKAction.fadeAlpha(to: intensity, duration: Double(time))) {
            Graphics.pulseAlpha(min: min, max: max, maxDelay: maxDelay, node: node)
        }*/
    }
    
    public class func pulseScale(min:CGFloat, max:CGFloat, minDelay: CGFloat, maxDelay:CGFloat, node:SKNode) {
        /*let intensity = CGFloat.random(min: min, max: max)
        let time = CGFloat.random(min: minDelay, max: maxDelay)
        let action = SKAction.scale(to: intensity, duration: Double(time))
        action.timingMode = .easeInEaseOut
        node.run(action) {
            Graphics.pulseScale(min: min, max: max, minDelay:minDelay, maxDelay: maxDelay, node: node)
        }*/
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
    
    public class func getLeftBound(scene:SKScene) -> CGFloat {
        if let _ = scene.view {
            return scene.convertPoint(fromView: CGPoint(x:0, y:0)).x
        }
        return 0
    }
    
    public class func getRightBound(scene:SKScene) -> CGFloat {
        if let view = scene.view {
            let max = view.frame.size
            return scene.convertPoint(fromView: CGPoint(x:max.width, y:0)).x
        }
        return 0
    }
}
