//
//  String+Extensions.swift
//  Barric's Tale
//
//  Created by Ryan Campbell on 3/27/15.
//  Copyright (c) 2015 Phalanx Studios. All rights reserved.
//

import Foundation

public extension String
{
    public func replace(target: String, withString: String) -> String
    {
        return self.stringByReplacingOccurrencesOfString(target, withString: withString, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
}