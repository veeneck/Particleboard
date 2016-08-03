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
        
        let delayTime = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            closure()
        }

    }
    
}
