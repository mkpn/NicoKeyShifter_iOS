//
//
//

import Foundation
import Factory

public extension Container {
    var notificationPermissionRepository: Factory<NotificationPermissionRepository> {
        self {
            NotificationPermissionRepositoryImpl(notificationPermissionDao: self.notificationPermissionDao())
        }
    }
}

public protocol NotificationPermissionRepository {
    func hasNotificationPermission() async -> Bool
    func updateNotificationPermissionRequested()
    func isNotificationPermissionRequested() async -> Bool
}

public final class NotificationPermissionRepositoryImpl: NotificationPermissionRepository {
    @Injected(\.notificationPermissionDao) var notificationPermissionDao
    
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
    
    public func isNotificationPermissionRequested() async -> Bool {
        let status = await notificationPermissionDao.getNotificationPermissionStatus()
        // notDeterminedじゃなければ過去にリクエスト実績ありとして扱う
        return status != .notDetermined
    }
}
