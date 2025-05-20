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
    func getTrackingPermissionStatus() async -> ATTrackingManager.AuthorizationStatus
}

class TrackingPermissionDaoImpl: TrackingPermissionDao {
    public func getTrackingPermissionStatus() async -> ATTrackingManager.AuthorizationStatus {
        return ATTrackingManager.trackingAuthorizationStatus
    }
}
