//
//
//

import Foundation

public struct SearchVideoUiState: Equatable {
    
    public let isLoading: Bool
    public let query: String
    public let videos: [VideoDomainModel]
    public let errorMessage: String?
    public let isNotificationPermissionRequested: Bool
    public let isATTPermissionRequested: Bool

    public init(
        isLoading: Bool = false,
        query: String = "",
        videos: [VideoDomainModel] = [],
        errorMessage: String? = nil,
        isNotificationPermissionRequested: Bool = true,
        isATTPermissionRequested: Bool = true
    ) {
        print("uiState init")
        self.isLoading = isLoading
        self.query = query
        self.videos = videos
        self.errorMessage = errorMessage
        self.isNotificationPermissionRequested = isNotificationPermissionRequested
        self.isATTPermissionRequested = isATTPermissionRequested
    }

    public var modalTarget: ModalTarget {
        if !isNotificationPermissionRequested {
            return .notification
        }
        if !isATTPermissionRequested {
            return .att
        }
        return .none
    }

    public var isEmpty: Bool {
        !isLoading && !query.isEmpty && videos.isEmpty && errorMessage == nil
    }
    
    public var isInitialState: Bool {
        !isLoading && query.isEmpty && videos.isEmpty && errorMessage == nil
    }
    
    public var isError: Bool {
        errorMessage != nil
    }
    
    public var isSuccess: Bool {
        !isLoading && !query.isEmpty && errorMessage == nil
    }

    public func copy(
        isLoading: Bool? = nil,
        query: String? = nil,
        videos: [VideoDomainModel]? = nil,
        errorMessage: String?? = nil,
        isNotificationPermissionRequested: Bool? = nil,
        isATTPermissionRequested: Bool? = nil
    ) -> SearchVideoUiState {
        print("uiState copy : \(isATTPermissionRequested)")
        return SearchVideoUiState(
            isLoading: isLoading ?? self.isLoading,
            query: query ?? self.query,
            videos: videos ?? self.videos,
            errorMessage: errorMessage ?? self.errorMessage,
            isNotificationPermissionRequested: isNotificationPermissionRequested ?? self.isNotificationPermissionRequested,
            isATTPermissionRequested: isATTPermissionRequested ?? self.isATTPermissionRequested
        )
    }

    
    public static func ofDefault() -> SearchVideoUiState {
        SearchVideoUiState(
            isLoading: false,
            videos: [VideoDomainModel.ofDefault()],
            errorMessage: nil,
            isNotificationPermissionRequested: false,
            isATTPermissionRequested: false
        )
    }
}
