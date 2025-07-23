//
//
//

import Foundation
import Factory
import Data

public extension Container {
    var getTrackingAuthorizationStatusUseCase: Factory<GetTrackingAuthorizationStatusUseCase & Sendable> {
        self {
            GetTrackingAuthorizationStatusUseCaseImpl()
        }
    }
}

public protocol GetTrackingAuthorizationStatusUseCase {
    func invoke() async -> TrackingPermissionStatus
}

public final class GetTrackingAuthorizationStatusUseCaseImpl: GetTrackingAuthorizationStatusUseCase {
    private let trackingPermissionRepository: TrackingPermissionRepository = Container.shared.trackingPermissionRepository()
    
    public func invoke() async -> TrackingPermissionStatus {
        return await trackingPermissionRepository.getTrackingAuthorizationStatus()
    }
}
