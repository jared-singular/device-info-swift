# Device Info Swift Library

DeviceInfo Swift is a lightweight iOS utility that provides essential device data collection required for Singular Server-to-Server (S2S) REST API integration. The project consists of two main components that work together to gather crucial device information for maintaining device graphs and processing out-of-app events.

TL;DR:
- Swift utility classes for collecting iOS device data required for Singular S2S integration
- Captures essential identifiers like IDFA, IDFV, and ATT status
- Provides device information including model, OS version, and build details
- Designed for maintaining device graphs and processing out-of-app events

## Core Components

**DeviceIdentifiers Class**
```swift
class DeviceIdentifiers {
    static let shared = DeviceIdentifiers()
    
    var attStatus: String
    var idfa: String
    var idfv: String
    
    func requestTrackingAuthorization(completion: @escaping (String) -> Void)
    func getAllIdentifiers() -> [String: String]
}
```

**DeviceInfo Class**
```swift
class DeviceInfo {
    static let shared = DeviceInfo()
    
    var appVersion: String
    var bundleID: String
    var osVersion: String
    var locale: String
    var deviceModel: String
    var buildVersion: String
    
    func getAllDeviceInfo() -> [String: String]
}
```

## Data Points

**Device Identifiers**
- `attStatus`: App Tracking Transparency status (iOS 14+)
- `idfa`: Advertising identifier for user tracking
- `idfv`: Vendor identifier as fallback identifier

**Device Information**
- `appVersion`: Current app version from bundle
- `bundleID`: Application bundle identifier
- `osVersion`: Current iOS version
- `locale`: Device's current locale setting
- `deviceModel`: Physical device model information
- `buildVersion`: System build version using sysctlbyname

## Implementation Guide

1. Initialize the components:
```swift
let deviceInfo = DeviceInfo.shared
let deviceIdentifiers = DeviceIdentifiers.shared
```

2. Collect device information:
```swift
let deviceData = deviceInfo.getAllDeviceInfo()
let identifierData = deviceIdentifiers.getAllIdentifiers()
```

3. Request ATT authorization when needed:
```swift
deviceIdentifiers.requestTrackingAuthorization { status in
    // Handle ATT status
}
```

## Server Integration

### Device Graph Storage
Store collected data points in your device graph with these key considerations:
- Map multiple identifiers to a single user profile
- Update data points periodically to maintain accuracy
- Handle missing or null values gracefully

### Singular API Integration
When sending events to Singular's REST API:
1. Retrieve stored device information from your device graph
2. Include relevant device data in the API payload
3. Ensure consistent identifier usage across events

## Technical Requirements

- iOS 14.0+
- Swift 5.0+
- Xcode 13.0+
- Required frameworks:
  - AdSupport.framework
  - AppTrackingTransparency.framework
  - UIKit.framework

## Best Practices

- Store collected information server-side for consistent tracking
- Update device information periodically to maintain accuracy
- Handle ATT status changes appropriately
- Implement proper error handling for missing data points
- Use the data points when sending event requests to Singular's API

## Debugging

The app provides two ways to verify collected data:
- Xcode console output through printDeviceInfo()
- Visual representation in the DeviceInfoView

## Screenshots
| About the App | DeviceInfo Dictionary |
|----------|----------|
| ![simulator_screenshot_26456FF5-08E3-498D-A001-89B1B3FA7370](https://github.com/user-attachments/assets/0dca0694-de9a-4703-a0cc-e72e36f90180)   | ![simulator_screenshot_5C2E2C17-4273-4F92-BC81-E6F05E449EF3](https://github.com/user-attachments/assets/518eba87-7588-4578-9b8a-eeadc3f3d5a7)   |


## License
[See LICENSE](https://github.com/jared-singular/device-info-swift/blob/main/LICENSE)
