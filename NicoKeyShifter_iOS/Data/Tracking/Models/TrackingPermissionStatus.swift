//
//
//

import Foundation
import AppTrackingTransparency

public enum TrackingPermissionStatus {
    case notDetermined
    case restricted
    case denied
    case authorized
    
    public static func fromATTrackingManagerAuthorizationStatus(_ status: ATTrackingManager.AuthorizationStatus) -> TrackingPermissionStatus {
        switch status {
        case .notDetermined:
            return .notDetermined
        case .restricted:
            return .restricted
        case .denied:
            return .denied
        case .authorized:
            return .authorized
        @unknown default:
            return .notDetermined
        }
    }
}
