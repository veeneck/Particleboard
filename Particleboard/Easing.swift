//
//  easing.swift
//
//  Created by CraigGrummitt on 6/08/2014.
//  Copyright (c) 2014 CraigGrummitt. All rights reserved.
//
//  Based on easing.c
//
//  Copyright (c) 2011, Auerhaus Development, LLC
//
//  This program is free software. It comes without any warranty, to
//  the extent permitted by applicable law. You can redistribute it
//  and/or modify it under the terms of the Do What The Fuck You Want
//  To Public License, Version 2, as published by Sam Hocevar. See
//  http://sam.zoy.org/wtfpl/COPYING for more details.
//

import Foundation

let M_PI_2_f = Float(M_PI_2)
let M_PI_f = Float(M_PI)

typealias AHEasingFunction = (Float)->Float

public func dub(num:Float)->Float {
    return (Float(Int32(num)))
}
public func sinFloat(num:Float)->Float {
    return sin(num)
}
// Modeled after the line y = x
public func LinearInterpolation(p:Float)->Float
{
    return p;
}

// Modeled after the parabola y = x^2
public func  QuadraticEaseIn(p:Float)->Float
{
    return p * p;
}

// Modeled after the parabola y = -x^2 + 2x
public func QuadraticEaseOut(p:Float)->Float
{
    return -(p * (p - 2));
}

// Modeled after the piecewise quadratic
// y = (1/2)((2x)^2)             ; [0, 0.5)
// y = -(1/2)((2x-1)*(2x-3) - 1) ; [0.5, 1]
public func QuadraticEaseInOut(p:Float)->Float
{
    if(p < 0.5)
    {
        return 2 * p * p;
    }
    else
    {
        return (-2 * p * p) + (4 * p) - 1;
    }
}

// Modeled after the cubic y = x^3
public func CubicEaseIn(p:Float)->Float
{
    return p * p * p;
}

// Modeled after the cubic y = (x - 1)^3 + 1
public func CubicEaseOut(p:Float)->Float
{
    let f:Float = (p - 1);
    return f * f * f + 1;
}

// Modeled after the piecewise cubic
// y = (1/2)((2x)^3)       ; [0, 0.5)
// y = (1/2)((2x-2)^3 + 2) ; [0.5, 1]
public func CubicEaseInOut(p:Float)->Float
{
    if(p < 0.5)
    {
        return 4 * p * p * p;
    }
    else
    {
        let f:Float = ((2 * p) - 2);
        return 0.5 * f * f * f + 1;
    }
}

// Modeled after the quartic x^4
public func QuarticEaseIn(p:Float)->Float
{
    return p * p * p * p;
}

// Modeled after the quartic y = 1 - (x - 1)^4
public func QuarticEaseOut(p:Float)->Float
{
    let f:Float = (p - 1);
    return f * f * f * (1 - p) + 1;
}

// Modeled after the piecewise quartic
// y = (1/2)((2x)^4)        ; [0, 0.5)
// y = -(1/2)((2x-2)^4 - 2) ; [0.5, 1]
public func QuarticEaseInOut(p:Float)->Float
{
    if(p < 0.5)
    {
        return 8 * p * p * p * p;
    }
    else
    {
        let f:Float = (p - 1);
        return -8 * f * f * f * f + 1;
    }
}

// Modeled after the quintic y = x^5
public func QuinticEaseIn(p:Float)->Float
{
    return p * p * p * p * p;
}

// Modeled after the quintic y = (x - 1)^5 + 1
public func QuinticEaseOut(p:Float)->Float
{
    let f:Float = (p - 1);
    return f * f * f * f * f + 1;
}

// Modeled after the piecewise quintic
// y = (1/2)((2x)^5)       ; [0, 0.5)
// y = (1/2)((2x-2)^5 + 2) ; [0.5, 1]
public func QuinticEaseInOut(p:Float)->Float
{
    if(p < 0.5)
    {
        return 16 * p * p * p * p * p;
    }
    else
    {
        let f:Float = ((2 * p) - 2);
        return  0.5 * f * f * f * f * f + 1;
    }
}

// Modeled after quarter-cycle of sine wave
public func SineEaseIn(p:Float)->Float
{
    return sinFloat(num: (p - 1.0) * M_PI_2_f)+1.0
}

// Modeled after quarter-cycle of sine wave (different phase)
public func SineEaseOut(p:Float)->Float
{
    return sinFloat(num: p * M_PI_2_f)
}

// Modeled after half sine wave
public func SineEaseInOut(p:Float)->Float
{
    return 0.5 * (1.0 - cos(p * M_PI_f));
}

// Modeled after shifted quadrant IV of unit circle
public func CircularEaseIn(p:Float)->Float
{
    return 1 - sqrt(1 - (p * p));
}

// Modeled after shifted quadrant II of unit circle
public func CircularEaseOut(p:Float)->Float
{
    return sqrt((2 - p) * p);
}

// Modeled after the piecewise circular function
// y = (1/2)(1 - sqrt(1 - 4x^2))           ; [0, 0.5)
// y = (1/2)(sqrt(-(2x - 3)*(2x - 1)) + 1) ; [0.5, 1]
public func CircularEaseInOut(p:Float)->Float
{
    if(p < 0.5)
    {
        return 0.5 * (1 - sqrt(1 - 4 * (p * p)));
    }
    else
    {
        return 0.5 * (sqrt(-((2 * p) - 3) * ((2 * p) - 1)) + 1);
    }
}

// Modeled after the exponential function y = 2^(10(x - 1))
public func ExponentialEaseIn(p:Float)->Float
{
    return (p == 0.0) ? p : pow(2, 10 * (p - 1));
}

// Modeled after the exponential function y = -2^(-10x) + 1
public func ExponentialEaseOut(p:Float)->Float
{
    return (p == 1.0) ? p : 1 - pow(2, -10 * p);
}

// Modeled after the piecewise exponential
// y = (1/2)2^(10(2x - 1))         ; [0,0.5)
// y = -(1/2)*2^(-10(2x - 1))) + 1 ; [0.5,1]
public func ExponentialEaseInOut(p:Float)->Float
{
    if(p == 0.0 || p == 1.0) { return p; }
    
    if(p < 0.5)
    {
        return 0.5 * pow(2, (20 * p) - 10);
    }
    else
    {
        return -0.5 * pow(2, (-20 * p) + 10) + 1;
    }
}

// Modeled after the damped sine wave y = sin(13pi/2*x)*pow(2, 10 * (x - 1))
public func ElasticEaseIn(p:Float)->Float
{
    return sinFloat(num: 13 * M_PI_2_f * p) * pow(2, 10.0 * (p - 1.0));
}

// Modeled after the damped sine wave y = sin(-13pi/2*(x + 1))*pow(2, -10x) + 1
public func ElasticEaseOut(p:Float)->Float
{
    return sinFloat(num: -13 * M_PI_2_f * (p + 1)) * pow(2, -10 * p) + 1;
}

// Modeled after the piecewise exponentially-damped sine wave:
// y = (1/2)*sin(13pi/2*(2*x))*pow(2, 10 * ((2*x) - 1))      ; [0,0.5)
// y = (1/2)*(sin(-13pi/2*((2x-1)+1))*pow(2,-10(2*x-1)) + 2) ; [0.5, 1]
public func ElasticEaseInOut(p:Float)->Float
{
    if(p < 0.5)
    {
        return 0.5 * sinFloat(num: 13.0 * M_PI_2_f * (2 * p)) * pow(2, 10 * ((2 * p) - 1));
    }
    else
    {
        return 0.5 * (sinFloat(num: -13 * M_PI_2_f * ((2 * p - 1) + 1)) * pow(2, -10 * (2 * p - 1)) + 2);
    }
}

// Modeled after the overshooting cubic y = x^3-x*sin(x*pi)
public func BackEaseIn(p:Float)->Float
{
    return p * p * p - p * sinFloat(num: p * M_PI_f);
}

// Modeled after overshooting cubic y = 1-((1-x)^3-(1-x)*sin((1-x)*pi))
public func BackEaseOut(p:Float)->Float
{
    let f:Float = (1 - p);
    return 1 - (f * f * f - f * sinFloat(num: f * M_PI_f));
}

// Modeled after the piecewise overshooting cubic function:
// y = (1/2)*((2x)^3-(2x)*sin(2*x*pi))           ; [0, 0.5)
// y = (1/2)*(1-((1-x)^3-(1-x)*sin((1-x)*pi))+1) ; [0.5, 1]
public func BackEaseInOut(p:Float)->Float
{
    if(p < 0.5)
    {
        let f:Float = 2 * p;
        return 0.5 * (f * f * f - f * sinFloat(num: f * M_PI_f));
    }
    else
    {
        let f:Float = (1 - (2*p - 1));
        return 0.5 * (1 - (f * f * f - f * sinFloat(num: f * M_PI_f))) + 0.5;
    }
}

public func BounceEaseIn(p:Float)->Float
{
    return 1 - BounceEaseOut(p: 1 - p);
}

public func BounceEaseOut(p:Float)->Float
{
    if(p < 4/11.0)
    {
        return (121 * p * p)/16.0;
    }
    else if(p < 8/11.0)
    {
        return (363/40.0 * p * p) - (99/10.0 * p) + 17/5.0;
    }
    else if(p < 9/10.0)
    {
        return (4356/361.0 * p * p) - (35442/1805.0 * p) + 16061/1805.0;
    }
    else
    {
        return (54/5.0 * p * p) - (513/25.0 * p) + 268/25.0;
    }
}

public func BounceEaseInOut(p:Float)->Float
{
    if(p < 0.5)
    {
        return 0.5 * BounceEaseIn(p: p*2);
    }
    else
    {
        return 0.5 * BounceEaseOut(p: p * 2 - 1) + 0.5;
    }
}

func pointInLine(A:CGPoint, B:CGPoint, T:CGFloat) -> CGPoint {
    var C = CGPoint()
    C.x = A.x - ((A.x - B.x) * T)
    C.y = A.y - ((A.y - B.y) * T)
    return C
}

func pointInQuadCurve(p0:CGPoint, p1:CGPoint, p2:CGPoint, T:CGFloat) -> CGPoint {
    let A = pointInLine(A: p0, B: p1, T: T)
    let B = pointInLine(A: p1, B: p2, T: T)
    return pointInLine(A: A, B: B, T: T) // The point in the quad curve
}

public func pointInCubicCurve(p0:CGPoint, p1:CGPoint, p2:CGPoint, p3:CGPoint, T:CGFloat) -> CGPoint {
    let A = pointInQuadCurve(p0: p0, p1: p1, p2: p2, T: T);
    let B = pointInQuadCurve(p0: p1, p1: p2, p2: p3, T: T);
    return pointInLine(A: A, B: B, T: T);
}
