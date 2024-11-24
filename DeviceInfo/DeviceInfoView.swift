//
//  DeviceInfoView.swift
//  DeviceInfo
//
//  Created by Jared Ornstead on 11/23/24.
//

import SwiftUI
import AppTrackingTransparency

// DeviceInfoView.swift (Your existing view logic)
struct DeviceInfoView: View {
    let deviceInfo = DeviceInfo.shared
    @State private var isDataRefreshed = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("DeviceInfo Dictionary")
                .font(.title)
                .padding(.top)

            Text("Required Data Points")
                .font(.headline)
                .padding(.vertical, 5)
            
            Text("These device data points are required for all Singular Event REST API calls and must be captured client-side and stored on your server.")
                .font(.subheadline)
                .padding(.horizontal, 10)

            Divider()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("BundleID: \(deviceInfo.bundleID)")
                Text("App Version: \(deviceInfo.appVersion)")
                Text("ATT Status: \(deviceInfo.attStatus)")
                Text("IDFA: \(deviceInfo.idfa)")
                Text("IDFV: \(deviceInfo.idfv)")
                Text("Locale: \(deviceInfo.locale)")
                Text("Device Model: \(deviceInfo.deviceModel)")
                Text("Build Version: \(deviceInfo.buildVersion)")
                Text("OS Version: \(deviceInfo.osVersion)")
            }
            .padding()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            ATTrackingManager.requestTrackingAuthorization { status in
                DispatchQueue.main.async {
                    isDataRefreshed.toggle()
                }
            }
        }
        .id(isDataRefreshed)
    }
}

#Preview {
    DeviceInfoView()
}
