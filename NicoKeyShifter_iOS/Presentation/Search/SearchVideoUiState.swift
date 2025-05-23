//
//
//

import Foundation

public struct SearchVideoUiState {
    public let isLoading: Bool
    public let query: String
    public let videos: [VideoDomainModel]
    public let errorMessage: String?
    public let showNotificationPermissionDialog: Bool
    
    public init(
        isLoading: Bool = false,
        query: String = "",
        videos: [VideoDomainModel] = [],
        errorMessage: String? = nil,
        showNotificationPermissionDialog: Bool = false
    ) {
        self.isLoading = isLoading
        self.query = query
        self.videos = videos
        self.errorMessage = errorMessage
        self.showNotificationPermissionDialog = showNotificationPermissionDialog
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
    
    public static func ofDefault() -> SearchVideoUiState {
        SearchVideoUiState(
            isLoading: false,
            videos: [VideoDomainModel.ofDefault()],
            errorMessage: nil,
            showNotificationPermissionDialog: false
        )
    }
}
