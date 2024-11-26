//
//  DeviceInfo.swift
//  DeviceInfo
//
//  Created by Jared Ornstead on 11/22/24.
//

import Foundation
import UIKit
import Darwin

class DeviceInfo {
    static let shared = DeviceInfo()
    private init() {}
    
    var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown"
    }
    
    var bundleID: String {
        Bundle.main.bundleIdentifier ?? ""
    }
    
    var osVersion: String {
        UIDevice.current.systemVersion
    }
    
    var locale: String {
        Locale.current.identifier
    }
    
    let deviceMake = "Apple"
    
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
    
    func getAllDeviceInfo() -> [String: String] {
        return [
            "bundleID": bundleID,
            "appVersion": appVersion,
            "locale": locale,
            "deviceMake": deviceMake,
            "deviceModel": deviceModel,
            "buildVersion": buildVersion,
            "osVersion": osVersion
        ]
    }
    
    func printDeviceInfo() {
        print("Bundle ID: \(bundleID)")
        print("App Version: \(appVersion)")
        print("Locale: \(locale)")
        print("Device Make: \(deviceMake)")
        print("Device Model: \(deviceModel)")
        print("Build Version: \(buildVersion)")
        print("OS Version: \(osVersion)")
    }
}
