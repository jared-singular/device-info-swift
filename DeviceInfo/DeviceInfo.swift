//
//  DeviceInfo.swift
//  DeviceInfo
//
//  Created by Jared Ornstead on 11/22/24.
//

import Foundation
import UIKit
import AdSupport
import Darwin
import AppTrackingTransparency

class DeviceInfo {
    // Singleton instance
    static let shared = DeviceInfo()
    
    private init() {}
    
    var appVersion: String {
            return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown"
    }
    
    var osVersion: String {
            return UIDevice.current.systemVersion
    }
    
    var bundleID: String {
            Bundle.main.bundleIdentifier ?? ""
        }
    
    // Add this new property
        var attStatus: String {
            if #available(iOS 14, *) {
                let status = ATTrackingManager.trackingAuthorizationStatus
                switch status {
                case .notDetermined:
                    return "0"
                case .restricted:
                    return "1"
                case .denied:
                    return "2"
                case .authorized:
                    return "3"
                @unknown default:
                    return "unknown"
                }
            }
            return "authorized"
        }
    
    // Device Identifiers
    var idfa: String {
        ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    var idfv: String {
        UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    // System Information
    var locale: String {
        Locale.current.identifier
    }
    
    var deviceMake = "Apple"
    
    var deviceModel: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        return machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
    }
    
    var buildVersion: String {
        var size: Int = 0
        sysctlbyname("kern.osversion", nil, &size, nil, 0)
        var build = [CChar](repeating: 0, count: size)
        sysctlbyname("kern.osversion", &build, &size, nil, 0)
        let rawBuild = String(cString: build)
        return "Build/\(rawBuild)"
    }
    
    // Helper method to get all info at once
    func getAllDeviceInfo() -> [String: String] {
        return [
            "bundleID": bundleID,
            "appVersion": appVersion,
            "attStatus": attStatus,
            "idfa": idfa,
            "idfv": idfv,
            "locale": locale,
            "deviceMake": deviceMake,
            "deviceModel": deviceModel,
            "buildVersion": buildVersion,
            "osVersion": osVersion
        ]
    }
    
    // Print all information
    func printDeviceInfo() {
        print("Bundle ID: \(bundleID)")
        print("App Version: \(appVersion)")
        print("ATT Status: \(attStatus)")
        print("IDFA: \(idfa)")
        print("IDFV: \(idfv)")
        print("Locale: \(locale)")
        print("Device Make: \(deviceMake)")
        print("Device Model: \(deviceModel)")
        print("Build Version: \(buildVersion)")
        print("OS Version: \(osVersion)")
    }
}
