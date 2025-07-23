//
//
//

import Foundation
import Factory
import Data

public extension Container {
    var checkNotificationPermissionUseCase: Factory<CheckNotificationPermissionUseCase & Sendable> {
        self {
            CheckNotificationPermissionUseCaseImpl()
        }
    }
}

public protocol CheckNotificationPermissionUseCase {
    func invoke() async -> Bool
}

public final class CheckNotificationPermissionUseCaseImpl: CheckNotificationPermissionUseCase {
    private let notificationPermissionRepository = Container.shared.notificationPermissionRepository()
    
    public func invoke() async -> Bool {
        return await notificationPermissionRepository.hasNotificationPermission()
    }
}
