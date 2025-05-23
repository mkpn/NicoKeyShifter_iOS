//
//
//

import Foundation
import AppTrackingTransparency
import Factory

public extension Container {
    var trackingPermissionDao: Factory<TrackingPermissionDao & Sendable> {
        self {
            TrackingPermissionDaoImpl()
        }
    }
}

public protocol TrackingPermissionDao {
    func getTrackingPermissionStatus() async -> TrackingPermissionStatus
}

class TrackingPermissionDaoImpl: TrackingPermissionDao, Sendable {
    public func getTrackingPermissionStatus() async -> TrackingPermissionStatus {
        let status = ATTrackingManager.trackingAuthorizationStatus
        return TrackingPermissionStatus.fromATTrackingManagerAuthorizationStatus(status)
    }
}
