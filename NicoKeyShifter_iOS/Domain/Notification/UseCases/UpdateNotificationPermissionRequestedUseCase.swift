//
//
//

import Foundation
import Factory
import Data

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
    private let notificationPermissionRepository = Container.shared.notificationPermissionRepository()
    
    public func invoke() {
        notificationPermissionRepository.updateNotificationPermissionRequested()
    }
}
