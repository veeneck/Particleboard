//
//  CGRect+Extensions.swift
//  With War & Woe
//
//  Created by Ryan Campbell on 8/7/15.
//  Copyright © 2015 Ryan Campbell. All rights reserved.
//

import SpriteKit

/**
    Additional geometry functions to make CGRect more powerful.
*/
public extension CGRect {
    
    /// Given a point outside of the rectangle, this will find out where that point would intersect the recentangles edge
    /// if a line where to be drawn from the point to the center of the rectangle.
    public func lineFromCenterIntersectsSide(endPoint:CGPoint) -> (intersection:CGPoint, side:CGRectSide) {
        
        var adjustedWidth : CGFloat = 0
        var adjustedHeight : CGFloat = 0
        var b1 : CGPoint
        var b2 : CGPoint
        var side : CGRectSide
        
        if(self.height > self.width) {
            let diff = self.height - self.width
            adjustedWidth = diff / 2
        }
        
        if(self.width > self.height) {
            let diff = self.width - self.height
            adjustedHeight = diff / 2
        }
        
        /// If the absolute value of the x points are greater than the y, we know the intersection is on the sides.
        let absX = abs(endPoint.x - self.midX)
        let absY = abs(endPoint.y - self.midY)
        if((absX + adjustedWidth) > (absY + adjustedHeight)) {
            
            // Figure out let or right side, and find interesect X
            if(endPoint.x < self.midX) {
                b1 = CGPoint(x:self.minX, y:self.maxY)
                b2 = CGPoint(x:self.minX, y:self.minY)
                side = CGRectSide.Left
            }
            else {
                b1 = CGPoint(x:self.maxX, y:self.maxY)
                b2 = CGPoint(x:self.maxX, y:self.minY)
                side = CGRectSide.Right
            }
            
        }
        // Intersection is on top or bottom
        else {
            // Figure out top or bottom side, and find interesect Y
            if(endPoint.y < self.midY) {
                b1 = CGPoint(x:self.minX, y:self.minY)
                b2 = CGPoint(x:self.maxX, y:self.minY)
                side = CGRectSide.Bottom
            }
            else {
                b1 = CGPoint(x:self.minX, y:self.maxY)
                b2 = CGPoint(x:self.maxX, y:self.maxY)
                side = CGRectSide.Top
            }
        }
        
        return (intersection: self.pointsIntersect(a1: endPoint, a2: CGPoint(x:self.midX, y:self.midY), b1: b1, b2: b2), side:side)
    }
    
    /// Determines the point of intersection between any two lines
    public func pointsIntersect(a1:CGPoint, a2:CGPoint, b1:CGPoint, b2:CGPoint) -> CGPoint {
        let b = a2 - a1
        let c = b1 - a1;
        let d = b2 - b1
        let bDotPerp = b.x * d.y - b.y * d.x
        let t = (c.x * d.y - c.y * d.x) / bDotPerp
        return a1 + (b * CGFloat(t))
    }
    
    
}

/// Useful, clean representation of the sides of a rectangle. Specifically used to determine which side a line intersects
/// so that follow up calculations (i.e.: anchor points) can be quicker.
public enum CGRectSide : Int {
    case Left = 1, Top = 2, Right = 3, Bottom = 4
}
