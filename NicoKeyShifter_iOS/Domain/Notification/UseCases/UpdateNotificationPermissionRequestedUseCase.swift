//
//
//

import Foundation
import Factory

public extension Container {
    var updateNotificationPermissionRequestedUseCase: Factory<UpdateNotificationPermissionRequestedUseCase & Sendable> {
        self {
            UpdateNotificationPermissionRequestedUseCaseImpl(notificationPermissionRepository: self.notificationPermissionRepository())
        }
    }
}

public protocol UpdateNotificationPermissionRequestedUseCase {
    func invoke()
}

public final class UpdateNotificationPermissionRequestedUseCaseImpl: UpdateNotificationPermissionRequestedUseCase {
    private let notificationPermissionRepository: NotificationPermissionRepository
    
    public init(notificationPermissionRepository: NotificationPermissionRepository) {
        self.notificationPermissionRepository = notificationPermissionRepository
    }
    
    public func invoke() {
        notificationPermissionRepository.updateNotificationPermissionRequested()
    }
}
