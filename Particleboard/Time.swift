//
//  Time.swift
//  Fort
//
//  Created by Ryan Campbell on 11/7/14.
//  Copyright (c) 2014 Ryan Campbell. All rights reserved.
//

import SpriteKit

public class Time {
    
    public class func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
}
