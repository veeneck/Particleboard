//
//  Logging.swift
//  Particleboard
//
//  Created by Ryan Campbell on 8/25/16.
//  Copyright © 2016 Phalanx Studios. All rights reserved.
//

public enum LogLevel : Int {
    case Info = 0, Debug = 1, Warning = 2, Error = 3, Important = 4
    
    var icon : String {
        switch self {
        case .Info: return "🔹"
        case .Debug: return "🇩"
        case .Warning: return "🔸"
        case .Error: return "🚫"
        case .Important: return "✅"
        }
    }
}

public func logged(_ text:String, file:String, level:LogLevel = LogLevel.Info, newline:Bool = false) {
    var skip = ""
    if newline == true {
        skip = "\n"
    }
    if let category = getDebugFileName(file: file) {
        print(skip + level.icon + category + ": " + text)
    }
}

/// If you want to hide logs from a certain callee, have that callee return nil
/// Otherwise, have the callee return a string
func getDebugFileName(file:String) -> String? {
    var ret : String? = nil
    if file.contains("SwitchBoard") {
        /// ret = nil
        ret = "SwitchBoard"
    }
    else if file.contains("Particleboard") {
        ret = "Particleboard"
    }
    else if file.contains("Barric") {
        ret = "Barric"
    }
    else if file.contains("DeckKit") {
        ret = "DeckKit"
    }
    else if file.contains("WarGUI") {
        ret = "WarGUI"
    }
    else if file.contains("FormationKit") {
        ret = "FormationKit"
    }
    return ret
}
