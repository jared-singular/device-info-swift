//
//  AboutView.swift
//  DeviceInfo
//
//  Created by Jared Ornstead on 11/23/24.
//

import SwiftUI

struct AboutView: View {
    let deviceInfo = DeviceInfo.shared
    
    var body: some View {
        VStack(spacing: 20) {
            Text("About the App")
                .font(.title)
                .padding(.top)
            
            VStack(alignment: .leading, spacing: 15) {
                Text("Version: \(deviceInfo.appVersion)")
                Text("Build: \(deviceInfo.buildVersion)")
                
                Divider()
                
                Text("Purpose")
                    .font(.headline)
                    .padding(.vertical, 5)
                
                Text("This app demonstrates how to obtain the required iOS device data points needed for sending Singular Server-to-Server REST API requests. The DeviceInfo class is used to extract the data points and store in a Dictionary.")
                    .padding(.bottom, 5)
                
                Text("This payload should be sent to your server and maintained in a device graph for the user. When an out-of-app event is sent from your server, you will then have the required data points to send an Event request to Singular.")
                    .padding(.bottom, 5)
                
                Text("This app also displays the data in the Xcode Console and the About View for development and debugging purposes.")
                    .padding(.bottom, 5)
                
                Text("Click the 'Info' button to see the DeviceInfo data points.")
                    
            }
            .padding()
            
            Spacer()
        }
        .navigationBarTitle("Device Info Sample App", displayMode: .inline)
    }
}

// Preview
#Preview {
    AboutView()
}
