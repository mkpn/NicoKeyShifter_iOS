//
//
//

import Foundation
import Factory
import Data

public extension Container {
    var checkNotificationPermissionRequestedUseCase: Factory<CheckNotificationPermissionRequestedUseCase & Sendable> {
        self {
            CheckNotificationPermissionRequestedUseCaseImpl()
        }
    }
}

public protocol CheckNotificationPermissionRequestedUseCase {
    func invoke() async -> Bool
}

public final class CheckNotificationPermissionRequestedUseCaseImpl: CheckNotificationPermissionRequestedUseCase {
    private let notificationPermissionRepository = Container.shared.notificationPermissionRepository()

    public func invoke() async -> Bool {
        return await notificationPermissionRepository.isNotificationPermissionRequested()
    }
}
