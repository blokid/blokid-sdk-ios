//
//  Event.swift
//  BlokID
//
//  Created by Netset on 26/12/24.
//

import Foundation

public struct Event {
    let name: String
    let additionalData: [String: Any]?
    
    init(name: String, additionalData: [String: Any]? = nil) {
        self.name = name
        self.additionalData = additionalData
    }
    
    // MARK: -  Convert Event to EventType
    func toEventType() -> EventType? {
        return EventType(rawValue: self.name)
    }
}

public enum EventType: String {
    case pageLoad = "PageLoad"
    case pageUnload = "PageUnload"
    case tabSwitch = "TabSwitch"
    case firstVisit = "FirstVisit"
    case sessionStart = "SessionStart"
    case click = "Click"
    case scroll = "Scroll"
}
