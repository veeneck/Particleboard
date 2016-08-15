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
        path.move(to: start)
        path.addLine(to: end)
        return path
    }
    
    public class func arcToPoint(start:CGPoint, end:CGPoint, next:CGPoint?) -> CGMutablePath {
        let path = CGMutablePath()
        path.move(to: start)
        if((next) != nil) {
            path.addArc(tangent1End: end, tangent2End: next!, radius: 150)
        }
        else {
            path.addLine(to: end)
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
        path.move(to: start)
        path.addLine(to: point1)
        path.addCurve(to: point2, control1: point1, control2: arcPoint)
        
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
        
        let cp1 = CGPoint(x:start.x + offsetX, y:start.y + offsetY + totalLift)
        let cp2 = CGPoint(x:start.x + (offsetX * 2), y: start.y + (offsetY * 2) + totalLift)
        
        // Make a path
        let path = CGMutablePath();
        path.move(to: start)
        path.addCurve(to: end, control1: cp1, control2: cp2)

        
        return path;
    }
    
    public class func pathFromPoints(points:[CGPoint]) -> CGPath {
        let path = CGMutablePath()
        path.move(to: points[0])

        
        for index in 1 ..< points.count {
            let tempPoint = points[index]
            path.addLine(to: tempPoint)
        }
        
        path.addLine(to: points[0])
        
        return path
    }
    
}
