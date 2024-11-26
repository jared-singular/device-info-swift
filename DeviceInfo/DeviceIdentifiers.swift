//
//  DeviceIdentifiers.swift
//  DeviceInfo
//
//  Created by Jared Ornstead on 11/26/24.
//

import Foundation
import UIKit
import AdSupport
import AppTrackingTransparency

class DeviceIdentifiers {
    static let shared = DeviceIdentifiers()
    private init() {}
    
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
    
    var idfa: String {
        ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    var idfv: String {
        UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    func requestTrackingAuthorization(completion: @escaping (String) -> Void) {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                DispatchQueue.main.async {
                    completion(self.attStatus)
                }
            }
        } else {
            completion("authorized")
        }
    }
    
    func getAllIdentifiers() -> [String: String] {
        return [
            "attStatus": attStatus,
            "idfa": idfa,
            "idfv": idfv
        ]
    }
    
    func printIdentifiers() {
        print("ATT Status: \(attStatus)")
        print("IDFA: \(idfa)")
        print("IDFV: \(idfv)")
    }
}
