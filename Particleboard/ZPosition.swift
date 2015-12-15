//
//  ZPosition.swift
//  Fort
//
//  Created by Ryan Campbell on 10/29/14.
//  Copyright (c) 2014 Ryan Campbell. All rights reserved.
//

import Foundation

public enum PositionCategory : Float {
    case WorldMax = 5000, Environment, Flag, Display
}

public class ZPosition {
    
    class func getGroundZPosition() -> Float {
        return 1
    }
    
    class func getUIPosition() -> Float {
        return PositionCategory.Display.rawValue
    }
    
}