//
//  CGPath+Extensions.swift
//  Barric's Tale
//
//  Created by Ryan Campbell on 3/30/15.
//  Copyright (c) 2015 Phalanx Studios. All rights reserved.
//

import SpriteKit

public extension CGPath {
    
    public class func lineToPoint(start:CGPoint, end:CGPoint) -> CGMutablePath {
        let path = CGMutablePath()
        path.moveTo(nil, x: start.x, y: start.y)
        path.addLineTo(nil, x: end.x, y: end.y);
        return path
    }
    
    public class func arcToPoint(start:CGPoint, end:CGPoint, next:CGPoint?) -> CGMutablePath {
        let path = CGMutablePath()
        path.moveTo(nil, x: start.x, y: start.y)
        if((next) != nil) {
            path.addArc(nil, x1: end.x, y1: end.y, x2: next!.x, y2: next!.y, radius: 150);
        }
        else {
            path.addLineTo(nil, x: end.x, y: end.y);
        }
        return path
    }
    
    /// Takes a starting point, and then draws a line +/- halfWidth radians from the heading.
    /// Then, connects the two lines with a curve making sure range is same
    public class func coneFromPoint(start:CGPoint, range:Float, heading:CGFloat, halfTurn:CGFloat) -> CGMutablePath {
        let path = CGMutablePath()
        let point1 = start + CGPoint(float2(angle:Float(heading + halfTurn)) * range)
        let point2 = start + (float2(angle:Float(heading - halfTurn)) * range)
        let arcPoint = start + (float2(angle:Float(heading)) * range)
        path.moveTo(nil, x: start.x, y: start.y)
        path.addLineTo(nil, x: point1.x, y: point1.y)
        path.addCurve(nil,
                      cp1x: point1.x, cp1y: point1.y,
                      cp2x: arcPoint.x, cp2y: arcPoint.y,
                      endingAtX: point2.x, y: point2.y)
        
        return path
    }
    
    public class func evenCurveToPoint(start:CGPoint, end:CGPoint, lift:CGFloat) -> CGMutablePath {
        
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
        let path = CGMutablePath();
        path.moveTo(nil, x: start.x, y: start.y);
        path.addCurve(nil,
                      cp1x: start.x + offsetX, cp1y: start.y + offsetY + totalLift,
                      cp2x: start.x + (offsetX * 2), cp2y: start.y + (offsetY * 2) + totalLift,
                      endingAtX: end.x, y: end.y);
        
        return path;
    }
    
    public class func pathFromPoints(points:[CGPoint]) -> CGPath {
        let path = CGMutablePath()
        path.moveTo(nil, x: points[0].x, y: points[0].y)
        
        for index in 1 ..< points.count {
            let tempPoint = points[index]
            path.addLineTo(nil, x: tempPoint.x, y: tempPoint.y)
        }
        
        path.addLineTo(nil, x: points[0].x, y: points[0].y)
        return path
    }
    
}
