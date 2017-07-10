//
//  Logging.swift
//  Particleboard
//
//  Created by Ryan Campbell on 8/25/16.
//  Copyright © 2016 Phalanx Studios. All rights reserved.
//

public enum LogLevel : Int {
    case Info = 0, Debug = 1, Warning = 2, Error = 3, Important = 4, Time = 5
    
    var icon : String {
        switch self {
        case .Info: return "🔹"
        case .Debug: return "🇩"
        case .Warning: return "🔸"
        case .Error: return "🚫"
        case .Important: return "💠"
        case .Time: return "⏳"
        }
    }
}

/// Disabled just means .Debug & .Info won't show
public enum CodePackage : String {
    case SwitchBoard = "SwitchBoard", Particleboard = "Particleboard", Barric = "Barric", DeckKit = "DeckKit", WarGUI = "WarGUI", FormationKit = "FormationKit", PathKit = "PathKit", AI = "AI"
    
    var enabled : Bool {
        switch self {
        case .SwitchBoard: return false
        case .Particleboard: return false
        case .Barric: return false
        case .DeckKit: return false
        case .WarGUI: return false
        case .FormationKit: return false
        case .AI: return false
        case .PathKit: return false
            
        }
    }
}

public func logged(_ text:String, file:String, level:LogLevel = LogLevel.Info, newline:Bool = false) {

    /*var skip = ""
    if newline == true {
        skip = "\n"
    }
    let category = getDebugFileName(file: file)
    if let package = CodePackage(rawValue: category) {
        if package.enabled || (level != .Debug && level != .Info) {
           print(skip + level.icon + category + ": " + text)
        }
    }*/
    
}

/// If you want to hide logs from a certain callee, have that callee return nil
/// Otherwise, have the callee return a string
func getDebugFileName(file:String) -> String {
    var ret = ""
    if file.contains("SwitchBoard") {
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
        if file.contains("AI") || file.contains("OrderService") || file.contains("AgendaFactory") {
            ret = "AI"
        }
        else {
            ret = "FormationKit"
        }
    }
    else if file.contains("PathKit") {
        ret = "PathKit"
    }
    return ret
}
