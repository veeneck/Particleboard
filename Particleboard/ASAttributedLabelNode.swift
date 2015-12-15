//
//  ASAttributedLabelNode.swift
//
//  Created by Alex Studnicka on 15/08/14.
//  Copyright (c) 2014 Alex Studnicka. All rights reserved.
//

import UIKit
import SpriteKit

public class ASAttributedLabelNode: SKSpriteNode {
    
    required public init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    public init(size: CGSize) {
        super.init(texture: nil, color: UIColor.blackColor(), size: size)
    }
    
    public var attributedString: NSAttributedString! {
        didSet { draw() }
    }
    
    public func draw() {
        
        if let attrStr = attributedString {
            let scaleFactor = UIScreen.mainScreen().scale
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue).rawValue
            let oContext = CGBitmapContextCreate(nil, Int(self.size.width * scaleFactor), Int(self.size.height * scaleFactor), 8, Int(self.size.width * scaleFactor * 4), colorSpace, bitmapInfo)
            if let context = oContext {
                CGContextScaleCTM(context, scaleFactor, scaleFactor)
                CGContextConcatCTM(context, CGAffineTransformMake(1, 0, 0, -1, 0, self.size.height));
                UIGraphicsPushContext(context)
                
                let strHeight = attrStr.boundingRectWithSize(size, options: .UsesLineFragmentOrigin, context: nil).height
                let yOffset = (self.size.height - strHeight) / 2.0
                attrStr.drawWithRect(CGRect(x: 0, y: yOffset, width: self.size.width, height: strHeight), options: .UsesLineFragmentOrigin, context: nil)
                
                let imageRef = CGBitmapContextCreateImage(context)
                UIGraphicsPopContext()
                self.texture = SKTexture(CGImage: imageRef!)
            }
        } else {
            self.texture = nil
        }
        
    }
    
    public func buildText(myString:String, mySize: CGFloat, myFont:String, alignment:NSTextAlignment = NSTextAlignment.Left) -> (NSMutableAttributedString) {
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.blackColor()
        shadow.shadowOffset = CGSizeMake (1.0, 1.0)
        shadow.shadowBlurRadius = 1
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        paragraphStyle.alignment = alignment
        
        let labelFont = UIFont(name: myFont, size: mySize)
        let labelColor = UIColor.whiteColor()
        
        let myAttributes = [
            NSParagraphStyleAttributeName : paragraphStyle,
            NSFontAttributeName : labelFont!,
            NSForegroundColorAttributeName : labelColor,
            NSShadowAttributeName : shadow]
        
        let myAttributedString = NSMutableAttributedString (string: myString, attributes:myAttributes)
        
        return  myAttributedString
    }
    
}