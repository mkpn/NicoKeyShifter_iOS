//
//
//

import Foundation
import Factory

public extension Container {
    var notificationPermissionRepository: Factory<NotificationPermissionRepository & Sendable> {
        self {
            NotificationPermissionRepositoryImpl(notificationPermissionDao: self.notificationPermissionDao())
        }
    }
}

public protocol NotificationPermissionRepository {
    func hasNotificationPermission() async -> Bool
    func updateNotificationPermissionRequested()
    func isNotificationPermissionRequested() -> Bool
}

public final class NotificationPermissionRepositoryImpl: NotificationPermissionRepository {
    private let notificationPermissionDao: NotificationPermissionDao
    
    public init(notificationPermissionDao: NotificationPermissionDao) {
        self.notificationPermissionDao = notificationPermissionDao
    }
    
    public func hasNotificationPermission() async -> Bool {
        let status = await notificationPermissionDao.getNotificationPermissionStatus()
        return status == .granted
    }
    
    public func updateNotificationPermissionRequested() {
        notificationPermissionDao.setNotificationPermissionRequested()
    }
    
    public func isNotificationPermissionRequested() -> Bool {
        return notificationPermissionDao.isNotificationPermissionRequested()
    }
}
