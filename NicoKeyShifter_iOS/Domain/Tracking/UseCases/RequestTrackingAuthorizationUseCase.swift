//
//
//

import Foundation
import Factory

public extension Container {
    var requestTrackingAuthorizationUseCase: Factory<RequestTrackingAuthorizationUseCase & Sendable> {
        self {
            RequestTrackingAuthorizationUseCaseImpl(trackingPermissionRepository: self.trackingPermissionRepository())
        }
    }
}

public protocol RequestTrackingAuthorizationUseCase {
    func invoke() async -> TrackingPermissionStatus
}

public final class RequestTrackingAuthorizationUseCaseImpl: RequestTrackingAuthorizationUseCase {
    private let trackingPermissionRepository: TrackingPermissionRepository
    
    public init(trackingPermissionRepository: TrackingPermissionRepository) {
        self.trackingPermissionRepository = trackingPermissionRepository
    }
    
    public func invoke() async -> TrackingPermissionStatus {
        return await trackingPermissionRepository.requestTrackingAuthorization()
    }
}
