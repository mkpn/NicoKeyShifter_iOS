//
//
//

import Foundation
import Factory

public extension Container {
    var trackingPermissionRepository: Factory<TrackingPermissionRepository & Sendable> {
        self {
            TrackingPermissionRepositoryImpl(trackingPermissionDao: self.trackingPermissionDao())
        }
    }
}

public protocol TrackingPermissionRepository {
    func isTrackingAuthorizationRequested() async -> Bool
}

public final class TrackingPermissionRepositoryImpl: TrackingPermissionRepository {
    
    private let trackingPermissionDao: TrackingPermissionDao
    
    public init(trackingPermissionDao: TrackingPermissionDao) {
        self.trackingPermissionDao = trackingPermissionDao
    }
    
    public func isTrackingAuthorizationRequested() async -> Bool {
        return await trackingPermissionDao.getTrackingPermissionStatus() != .notDetermined
    }
}
