//
//  DeviceInfoApp.swift
//  DeviceInfo
//
//  Created by Jared Ornstead on 11/22/24.
//

import SwiftUI
import AppTrackingTransparency
import AdSupport

@main
struct DeviceInfoApp: App {
    @State private var isTrackingAuthorized = false
    @State private var showAlert = false
    @State private var openURL: URL?
    
    // Initialize DeviceInfo
    let deviceInfo = DeviceInfo.shared
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .background(Color.white)
                .preferredColorScheme(.light)
                .onOpenURL(perform: { url in
                    openURL = url
                    print("App Scene: onOpenURL - \(url)")
                    showAlert = true
                })
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("OpenURL"),
                        message: Text((openURL!.absoluteString))
                    )
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                        switch status {
                        case .authorized:
                            print("Log: ATTrackingManager request successful")
                            print(Date(), "App IDFA: ", ASIdentifierManager.shared().advertisingIdentifier)
                            
                            // Print all device information when tracking is authorized
                            deviceInfo.printDeviceInfo()
                            
                            isTrackingAuthorized = true
                        case .denied,
                             .notDetermined,
                             .restricted:
                            // Still collect non-IDFA information
                            let info = deviceInfo.getAllDeviceInfo()
                            print("Device Info (excluding IDFA):")
                            print("IDFV: \(info["idfv"] ?? "")")
                            print("Locale: \(info["locale"] ?? "")")
                            print("Device Make: \(info["deviceMake"] ?? "")")
                            print("Device Model: \(info["deviceModel"] ?? "")")
                            print("Build Version: \(info["buildVersion"] ?? "")")
                            break
                        @unknown default:
                            break
                        }
                    })
                }
                .onChange(of: scenePhase) { oldValue, phase in
                    switch phase {
                    case .background:
                        print("App Scene: backgrounded")
                    case .inactive:
                        print("App Scene: inactive")
                    case .active:
                        print("App Scene: active")
                        // Optionally refresh device info when app becomes active
                        let info = deviceInfo.getAllDeviceInfo()
                        print("Updated Device Info:", info)
                    @unknown default:
                        print("App Scene: unknown")
                    }
                }
        }
    }
}
