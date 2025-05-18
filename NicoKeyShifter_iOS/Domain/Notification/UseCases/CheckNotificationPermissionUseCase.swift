//
//
//

import Foundation
import Factory

public extension Container {
    var checkNotificationPermissionUseCase: Factory<CheckNotificationPermissionUseCase & Sendable> {
        self {
            CheckNotificationPermissionUseCaseImpl(notificationPermissionRepository: self.notificationPermissionRepository())
        }
    }
}

public protocol CheckNotificationPermissionUseCase {
    func invoke() async -> Bool
}

public final class CheckNotificationPermissionUseCaseImpl: CheckNotificationPermissionUseCase {
    private let notificationPermissionRepository: NotificationPermissionRepository
    
    public init(notificationPermissionRepository: NotificationPermissionRepository) {
        self.notificationPermissionRepository = notificationPermissionRepository
    }
    
    public func invoke() async -> Bool {
        return await notificationPermissionRepository.hasNotificationPermission()
    }
}
