//
//  BlokIDTrack.swift
//  BlokID
//
//  Created by Netset on 26/12/24.
//

import UIKit
import WebKit

public class BlokIDTrack {
    
    var siteIdentifier = String()
    
    public init(siteIdentifier: String = "BLOKID-PIXEL-MOBILE") {
        self.siteIdentifier = siteIdentifier
        DataCollector.sharedInstance.userAgentValue = getUserAgent()
        DataCollector.sharedInstance.languageValue = Locale.current.identifier
        DataCollector.sharedInstance.platformValue = "ios"
        DataCollector.sharedInstance.screenWidthValue = UIScreen.main.bounds.width
        DataCollector.sharedInstance.screenHeightValue = UIScreen.main.bounds.height
        DataCollector.sharedInstance.colorDepthValue = 32
        DataCollector.sharedInstance.pixelDepthValue = 32
        DataCollector.sharedInstance.timezoneOffsetValue = (TimeZone.current.secondsFromGMT() / 60)
        //DataCollector.sharedInstance.sessionStorageValue = true
        DataCollector.sharedInstance.localStorageValue = true
        DataCollector.sharedInstance.cookiesEnabledValue = areCookiesEnabled()
        DataCollector.sharedInstance.currentUrlValue = "https://www.blokid.com/"
        DataCollector.sharedInstance.previousUrlValue = ""
        DataCollector.sharedInstance.touchSupportValue = isTouchSupported()
        DataCollector.sharedInstance.hardwareConcurrencyValue = getHardwareConcurrency()
        DataCollector.sharedInstance.deviceMemoryValue = getDeviceMemory()
        DataCollector.sharedInstance.timestampValue = ISO8601DateFormatter().string(from: Date())
        DataCollector.sharedInstance.canvasFingerprintValue = getCanvasFingerprint()
        DataCollector.sharedInstance.visibilityStateValue = "visible"
//        DataCollector.sharedInstance.pluginsValue = getPluginValue()
//        DataCollector.sharedInstance.mimeTypesValue = getMimeTypesValue()
    }
    
    public func trackEvent(event: EventType, additionalData: [String: Any]? = nil) {
        let event = Event(name: event.rawValue, additionalData: additionalData)
        let data = DataCollector.sharedInstance.collectData(event: event, siteIdentifier: siteIdentifier)
        NetworkManager.sendDataApiMethod(dataParam: data)
    }
    
    public func getEventDetail() {
        NetworkManager.fetchSavedRawEvents(siteIdentifier: siteIdentifier)
    }
    
    // MARK: - User Agent
    func getUserAgent() -> String {
        let webView = WKWebView(frame: .zero)
        return webView.value(forKey: "userAgent") as? String ?? "Unknown"
    }
    
    func getDeviceMemory() -> Int {
        return Int(ProcessInfo.processInfo.physicalMemory / (1024 * 1024 * 1024))
    }
    
    func areCookiesEnabled() -> Bool {
        let cookieStorage = HTTPCookieStorage.shared
        return cookieStorage.cookies?.count ?? 0 > 0
    }
    
    // MARK: - Touch Support
    func isTouchSupported() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone || UIDevice.current.userInterfaceIdiom == .pad
    }
    
    // MARK: - Hardware Concurrency
    func getHardwareConcurrency() -> Int {
        return ProcessInfo.processInfo.activeProcessorCount
    }
    
    func getPluginValue() -> [String] {
        let param = [
            "PDF Viewer",
            "Chrome PDF Viewer",
            "Chromium PDF Viewer",
            "Microsoft Edge PDF Viewer",
            "WebKit built-in PDF"
        ]
        return param
    }
    
    func getMimeTypesValue() -> [String] {
        let param = [
            "application/pdf",
            "text/pdf"
        ]
        return param
    }
    
    func getCanvasFingerprint() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""  //UUID().uuidString
    }
    
}
