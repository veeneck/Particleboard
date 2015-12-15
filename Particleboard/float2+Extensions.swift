//
//  flaot2+Extensions.swift
//  With War & Woe
//
//  Created by Ryan Campbell on 6/13/15.
//  Copyright © 2015 Ryan Campbell. All rights reserved.
//

import CoreGraphics
import simd

// Extend `float2` to add an initializer from a `CGPoint`.
public extension float2 {
    // MARK: Initialization
    
    /// Initialize with a `CGPoint` type.
    init(_ point: CGPoint) {
        self.init(x: Float(point.x), y: Float(point.y))
    }
    
    /// Initialize with a `Int` type.
    init(dx:Int, dy:Int) {
        self.init(x: Float(dx), y: Float(dy))
    }
    
    init(angle: Float) {
        self.init(x: cos(angle), y: sin(angle))
    }
    
    /**
    * Returns the angle in radians of the vector described by the CGVector.
    * The range of the angle is -π to π; an angle of 0 points to the right.
    */
    public var angle: Float {
        return atan2(y, x)
    }
}

/*
Extend `float2` to declare conformance to the `Equatable` protocol.
The conformance to the protocol is provided by the `==` operator function below.
*/
extension float2: Equatable {}

/// An equality operator function to determine if two `float2`s are the same.
public func ==(lhs: float2, rhs: float2) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}

// Extend `float2` to provide a convenience method for working with pathfinding graphs.
public extension float2 {
    /// Calculates the nearest point to this point on a line from `pointA` to `pointB`.
    public func nearestPointOnLineSegment(lineSegment: (startPoint: float2, endPoint: float2)) -> float2 {
        // A vector from this point to the line start.
        let vectorFromStartToLine = self - lineSegment.startPoint
        
        // The vector that represents the line segment.
        let lineSegmentVector = lineSegment.endPoint - lineSegment.startPoint
        
        // The length of the line squared.
        let lineLengthSquared = distance_squared(lineSegment.startPoint, lineSegment.endPoint)
        
        // The amount of the vector from this point that lies along the line.
        let projectionAlongSegment = dot(vectorFromStartToLine, lineSegmentVector)
        
        // Component of the vector from the point that lies along the line.
        let componentInSegment = projectionAlongSegment / lineLengthSquared
        
        // Clamps the component between [0 - 1].
        let fractionOfComponent = max(0, min(1, componentInSegment))
        
        return lineSegment.startPoint + lineSegmentVector * fractionOfComponent
    }
    
    /// Returns the angle between two points in radians
    public func angleBetweenPoints(end:float2) -> Float {
        return atan2(self.x * end.y - end.x * self.y, self.x * end.x + self.y * end.y)
    }
}
