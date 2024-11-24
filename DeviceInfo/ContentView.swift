//
//  ContentView.swift
//  DeviceInfo
//
//  Created by Jared Ornstead on 11/22/24.
//

import SwiftUI
import AppTrackingTransparency

// ContentView.swift
struct ContentView: View {
    var body: some View {
        NavigationView {
            AboutView()
                .navigationBarTitle("About")
                .navigationBarItems(trailing:
                    NavigationLink(destination: DeviceInfoView()) {
                        Image(systemName: "info.circle")
                    }
                )
        }
    }
}


#Preview {
    ContentView()
}
