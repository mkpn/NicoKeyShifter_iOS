//
//
//

import Foundation
import UserNotifications
import Factory

public extension Container {
    var notificationPermissionDao: Factory<NotificationPermissionDao & Sendable> {
        self {
            NotificationPermissionDaoImpl()
        }
    }
}

public protocol NotificationPermissionDao {
    func getNotificationPermissionStatus() async -> NotificationPermissionStatus
    func setNotificationPermissionRequested()
    func isNotificationPermissionRequested() -> Bool
}

class NotificationPermissionDaoImpl: NotificationPermissionDao {
    private let userDefaults = UserDefaults.standard
    private let notificationCenter = UNUserNotificationCenter.current()
    
    private let notificationPermissionRequestedKey = "notification_permission_requested"
    
    public func getNotificationPermissionStatus() async -> NotificationPermissionStatus {
        let settings = await notificationCenter.notificationSettings()
        
        switch settings.authorizationStatus {
        case .authorized, .provisional, .ephemeral:
            return .granted
        case .denied:
            return .denied
        case .notDetermined:
            return .notDetermined
        @unknown default:
            return .notDetermined
        }
    }
    
    public func setNotificationPermissionRequested() {
        userDefaults.set(true, forKey: notificationPermissionRequestedKey)
    }
    
    public func isNotificationPermissionRequested() -> Bool {
        return userDefaults.bool(forKey: notificationPermissionRequestedKey)
    }
}
