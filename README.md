# device-info-swift
Device Info Sample App in Swift

# DeviceInfo App

A lightweight iOS utility for collecting essential device information required for Singular Server-to-Server REST API integration.

## Overview

DeviceInfo is a Swift-based singleton class that provides a centralized way to collect crucial iOS device data points. This information is essential for maintaining device graphs and processing out-of-app events through Singular's API.

## Key Features

- Singleton architecture for consistent device information access
- Comprehensive device data collection
- ATT (App Tracking Transparency) status tracking
- System-level information gathering
- Easy integration with server-side implementations

## Core Components

**DeviceInfo Class**
```swift
class DeviceInfo {
    static let shared = DeviceInfo()
    private init() {}
}
```

## Data Points Collected

**App Information**
- `appVersion`: Retrieves the current app version from the bundle
- `bundleID`: Captures the application's bundle identifier
- `buildVersion`: Obtains the system build version using sysctlbyname

**Device Identifiers**
- `idfa`: Advertising identifier (IDFA) for user tracking
- `idfv`: Vendor identifier (IDFV) as a fallback identifier
- `deviceModel`: Physical device model information

**System Details**
- `osVersion`: Current iOS version
- `locale`: Device's current locale setting
- `attStatus`: App Tracking Transparency status (iOS 14+)

## Usage

**Retrieving All Device Information**
```swift
let deviceInfo = DeviceInfo.shared
let allInfo = deviceInfo.getAllDeviceInfo()
```

**Debugging Output**
```swift
DeviceInfo.shared.printDeviceInfo()
```

## Implementation Guide

1. Initialize the DeviceInfo singleton
2. Collect device information using getAllDeviceInfo()
3. Send the data to your server
4. Store the information in your device graph
5. Use the stored data points when sending event requests to Singular

## Best Practices

- Store device information server-side for consistent tracking
- Update device information periodically to maintain accuracy
- Handle ATT status changes appropriately
- Implement proper error handling for missing data points

## Integration with Singular

When sending Server-to-Server events:
1. Retrieve stored device information from your device graph
2. Include relevant device data points in your API requests
3. Maintain data consistency across different events

## Development and Debugging

The app provides two ways to verify collected data:
- Console output through printDeviceInfo()
- Visual representation in the About View

## Requirements

- iOS 14.0+
- Swift 5.0+
- Xcode 13.0+

## Dependencies

- AdSupport.framework
- AppTrackingTransparency.framework
- UIKit.framework

## License
