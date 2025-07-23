//
//
//

import Foundation
import Factory

public extension Container {
    var notificationPermissionRepository: Factory<NotificationPermissionRepository> {
        self {
            NotificationPermissionRepositoryImpl()
        }
    }
}

public protocol NotificationPermissionRepository {
    func hasNotificationPermission() async -> Bool
    func updateNotificationPermissionRequested()
    func isNotificationPermissionRequested() async -> Bool
}

public final class NotificationPermissionRepositoryImpl: NotificationPermissionRepository {
    private let notificationPermissionDao = Container.shared.notificationPermissionDao()
    
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
