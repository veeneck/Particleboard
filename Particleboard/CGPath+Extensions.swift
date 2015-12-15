//
//  CGPath+Extensions.swift
//  Barric's Tale
//
//  Created by Ryan Campbell on 3/30/15.
//  Copyright (c) 2015 Phalanx Studios. All rights reserved.
//

import SpriteKit

public extension CGPath {
    
    public class func lineToPoint(start:CGPoint, end:CGPoint) -> CGMutablePathRef {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, start.x, start.y)
        CGPathAddLineToPoint(path, nil, end.x, end.y);
        return path
    }
    
    public class func arcToPoint(start:CGPoint, end:CGPoint, next:CGPoint?) -> CGMutablePathRef {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, start.x, start.y)
        if((next) != nil) {
            CGPathAddArcToPoint(path, nil, end.x, end.y, next!.x, next!.y, 150);
        }
        else {
            CGPathAddLineToPoint(path, nil, end.x, end.y);
        }
        return path
    }
    
    /// Takes a starting point, and then draws a line +/- halfWidth radians from the heading.
    /// Then, connects the two lines with a curve making sure range is same
    public class func coneFromPoint(start:CGPoint, range:Float, heading:CGFloat, halfTurn:CGFloat) -> CGMutablePathRef {
        let path = CGPathCreateMutable()
        let point1 = start + CGPoint(float2(angle:Float(heading + halfTurn)) * range)
        let point2 = start + (float2(angle:Float(heading - halfTurn)) * range)
        let arcPoint = start + (float2(angle:Float(heading)) * range)
        CGPathMoveToPoint(path, nil, start.x, start.y)
        CGPathAddLineToPoint(path, nil, point1.x, point1.y)
        CGPathAddCurveToPoint(path, nil,
            point1.x, point1.y,
            arcPoint.x, arcPoint.y,
            point2.x, point2.y)
        
        return path
    }
    
    public class func evenCurveToPoint(start:CGPoint, end:CGPoint, lift:CGFloat) -> CGMutablePathRef {
        
        // Figure out how far we're traveling horizontally
        let distanceX = (start.x - end.x) * -1;
        let offsetX = distanceX / 3;
        
        // How far we're traveling vertically
        let distanceY = (start.y - end.y) * -1;
        let offsetY = distanceY / 3;
        
        var totalLift = offsetX * lift;
        if(totalLift < 0) {
            totalLift = totalLift * -1;
        }
        
        // Make a path
        let path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, start.x, start.y);
        CGPathAddCurveToPoint(path, nil,
            start.x + offsetX, start.y + offsetY + totalLift,
            start.x + (offsetX * 2), start.y + (offsetY * 2) + totalLift,
            end.x, end.y);
        
        return path;
    }
    
    public class func pathFromPoints(points:[CGPoint]) -> CGPath {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, points[0].x, points[0].y)
        
        for var index = 1; index < points.count; ++index {
            let tempPoint = points[index]
            CGPathAddLineToPoint(path, nil, tempPoint.x, tempPoint.y)
        }
        
        CGPathAddLineToPoint(path, nil, points[0].x, points[0].y)
        return path
    }
    
}
