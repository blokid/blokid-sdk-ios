//
//  DataCollector.swift
//  BlokID
//
//  Created by Netset on 26/12/24.
//

import Foundation

class DataCollector {
        
    var userAgentValue = String()
    var languageValue = String()
    var platformValue = String()
    var screenWidthValue = CGFloat()
    var screenHeightValue = CGFloat()
    var colorDepthValue = Int()
    var pixelDepthValue = Int()
    var timezoneOffsetValue = Int()
    var sessionStorageValue = Bool()
    var localStorageValue = Bool()
    var cookiesEnabledValue = Bool()
    var currentUrlValue = String()
    var previousUrlValue = String()
    var touchSupportValue = Bool()
    var hardwareConcurrencyValue = Int()
    var deviceMemoryValue = Int()
    var timestampValue = String()
    var canvasFingerprintValue = String()
    var visibilityStateValue = String()
    var pluginsValue = [String]()
    var mimeTypesValue = [String]()
    
    // MARK: - Create Instance
    static let sharedInstance = DataCollector()
    
    func collectData(event: Event, siteIdentifier: String) -> [String: Any] {
        var dataParam = [
            "userAgent": userAgentValue,
            "language": languageValue,
            "platform": platformValue,
            "screenWidth": screenWidthValue,
            "screenHeight": screenHeightValue,
            "colorDepth": colorDepthValue,
            "pixelDepth": pixelDepthValue,
            "timezoneOffset": timezoneOffsetValue,
            //"sessionStorage": sessionStorageValue,
            "localStorage": localStorageValue,
            "cookiesEnabled": cookiesEnabledValue,
            //"plugins": pluginsValue,
            "currentUrl": currentUrlValue,
            "previousUrl": previousUrlValue,
            //"mimeTypes": mimeTypesValue,
            "touchSupport": touchSupportValue,
            "hardwareConcurrency": hardwareConcurrencyValue,
            "deviceMemory": deviceMemoryValue,
            "siteIdentifier": siteIdentifier,
            "timestamp": timestampValue,
            "canvasFingerprint": canvasFingerprintValue,
            "visibilityState": visibilityStateValue,
            "event": event.name
        ] as [String:Any]
        if let additionalData = event.additionalData {
            for (key, value) in additionalData {
                if dataParam.keys.contains(key) {
                    dataParam[key] = value
                }
            }
        }
        return dataParam
    }
    
}
