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
    func getTrackingAuthorizationStatus() async -> TrackingPermissionStatus
    func requestTrackingAuthorization() async -> TrackingPermissionStatus
}

public final class TrackingPermissionRepositoryImpl: TrackingPermissionRepository {
    private let trackingPermissionDao: TrackingPermissionDao
    
    public init(trackingPermissionDao: TrackingPermissionDao) {
        self.trackingPermissionDao = trackingPermissionDao
    }
    
    public func getTrackingAuthorizationStatus() async -> TrackingPermissionStatus {
        return await trackingPermissionDao.getTrackingPermissionStatus()
    }
    
    public func requestTrackingAuthorization() async -> TrackingPermissionStatus {
        return await trackingPermissionDao.requestTrackingAuthorization()
    }
}
