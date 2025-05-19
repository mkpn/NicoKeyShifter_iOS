//
//
//

import Foundation
import Factory

public extension Container {
    var checkNotificationPermissionRequestedUseCase: Factory<CheckNotificationPermissionRequestedUseCase & Sendable> {
        self {
            CheckNotificationPermissionRequestedUseCaseImpl(notificationPermissionRepository: self.notificationPermissionRepository())
        }
    }
}

public protocol CheckNotificationPermissionRequestedUseCase {
    func invoke() async -> Bool
}

public final class CheckNotificationPermissionRequestedUseCaseImpl: CheckNotificationPermissionRequestedUseCase {
    private let notificationPermissionRepository: NotificationPermissionRepository
    
    public init(notificationPermissionRepository: NotificationPermissionRepository) {
        self.notificationPermissionRepository = notificationPermissionRepository
    }
    
    public func invoke() async -> Bool {
        return await notificationPermissionRepository.isNotificationPermissionRequested()
    }
}
