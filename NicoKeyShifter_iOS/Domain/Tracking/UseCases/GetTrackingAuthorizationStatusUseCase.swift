//
//
//

import Foundation
import Factory

public extension Container {
    var getTrackingAuthorizationStatusUseCase: Factory<GetTrackingAuthorizationStatusUseCase & Sendable> {
        self {
            GetTrackingAuthorizationStatusUseCaseImpl(trackingPermissionRepository: self.trackingPermissionRepository())
        }
    }
}

public protocol GetTrackingAuthorizationStatusUseCase {
    func invoke() async -> TrackingPermissionStatus
}

public final class GetTrackingAuthorizationStatusUseCaseImpl: GetTrackingAuthorizationStatusUseCase {
    private let trackingPermissionRepository: TrackingPermissionRepository
    
    public init(trackingPermissionRepository: TrackingPermissionRepository) {
        self.trackingPermissionRepository = trackingPermissionRepository
    }
    
    public func invoke() async -> TrackingPermissionStatus {
        return await trackingPermissionRepository.getTrackingAuthorizationStatus()
    }
}
