//
//
//

import Foundation
import Factory
import SwiftUI

@MainActor
public class SearchViewModel: ObservableObject {
    @Injected(\.searchVideoUseCase) private var searchVideoUseCase
    @Injected(\.checkNotificationPermissionRequestedUseCase) private var checkNotificationPermissionRequestedUseCase
    @Injected(\.getTrackingAuthorizationStatusUseCase) private var getTrackingAuthorizationStatusUseCase

    @Published var uiState = SearchVideoUiState()

    public init() {
        Task {
            let isNotificationPermissionRequested = await checkNotificationPermissionRequestedUseCase.invoke()
            let isATTAuthorizationRequested = await getTrackingAuthorizationStatusUseCase.invoke()

            uiState = SearchVideoUiState(
                isLoading: uiState.isLoading,
                query: uiState.query,
                videos: uiState.videos,
                errorMessage: uiState.errorMessage,
                isNotificationPermissionRequested: isNotificationPermissionRequested,
                isATTPermissionRequested: isATTAuthorizationRequested
            )
        }
    }
    
    public func search(
        query: String,
        targets: String = "title",
        sort: String = "-viewCounter",
        limit: Int = 100
    ) {
        if query.isEmpty {
            return
        }
        
        Task {
            do {
                let videos = try await searchVideoUseCase.invoke(
                    query: query,
                    targets: targets,
                    sort: sort,
                    limit: limit
                )
                
                uiState = uiState.copy(
                    isLoading: false,
                    query: query,
                    videos: videos,
                    errorMessage: nil as String?
                )
            } catch {
                let errorMessage = "検索中にエラーが発生しました: \(error.localizedDescription)"
                uiState = uiState.copy(
                    isLoading: false,
                    query: query,
                    videos: [],
                    errorMessage: errorMessage
                )
            }
        }
    }
    
    public func clearSearch() {
        uiState = uiState.copy(query: "", videos: [])
    }
    
    /**
     * 通知の権限について、uiStateのリクエスト済みフラグをtrueにする
     */
    public func finishNotificationPermissionRequested() {
        Task {
            uiState = uiState.copy(
                isNotificationPermissionRequested: true
            )
        }
    }

    /**
     * ATTの権限について、uiStateのリクエスト済みフラグをtrueにする
     */
    public func finishATTPermissionRequested() {
        print("finishATTPermissionRequested ")
        Task {
            uiState = uiState.copy(
                isATTPermissionRequested: true
            )
        }
    }
}
