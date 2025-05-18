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
    @Injected(\.updateNotificationPermissionRequestedUseCase) private var updateNotificationPermissionRequestedUseCase
    
    @Published private(set) var uiState = SearchVideoUiState()
    
    public init() {
        Task {
            let isNotificationPermissionRequested = checkNotificationPermissionRequestedUseCase.invoke()
            
            if !isNotificationPermissionRequested {
                uiState = SearchVideoUiState(
                    isLoading: uiState.isLoading,
                    query: uiState.query,
                    videos: uiState.videos,
                    errorMessage: uiState.errorMessage,
                    showNotificationPermissionDialog: true
                )
            }
        }
    }
    
    public func search(
        query: String,
        targets: String = "title",
        sort: String = "-viewCounter",
        limit: Int = 100
    ) {
        if query.isEmpty {
            uiState = SearchVideoUiState(
                showNotificationPermissionDialog: uiState.showNotificationPermissionDialog
            )
            return
        }
        
        uiState = SearchVideoUiState(
            isLoading: true,
            query: query,
            videos: [],
            errorMessage: nil,
            showNotificationPermissionDialog: uiState.showNotificationPermissionDialog
        )
        
        Task {
            do {
                let videos = try await searchVideoUseCase.invoke(
                    query: query,
                    targets: targets,
                    sort: sort,
                    limit: limit
                )
                
                uiState = SearchVideoUiState(
                    isLoading: false,
                    query: query,
                    videos: videos,
                    errorMessage: nil,
                    showNotificationPermissionDialog: uiState.showNotificationPermissionDialog
                )
            } catch {
                let errorMessage = "検索中にエラーが発生しました: \(error.localizedDescription)"
                uiState = SearchVideoUiState(
                    isLoading: false,
                    query: query,
                    videos: [],
                    errorMessage: errorMessage,
                    showNotificationPermissionDialog: uiState.showNotificationPermissionDialog
                )
            }
        }
    }
    
    public func clearSearch() {
        uiState = SearchVideoUiState(
            showNotificationPermissionDialog: uiState.showNotificationPermissionDialog
        )
    }
    
    /**
     * 通知の権限をリクエスト済みの状態に更新する
     * uiStateのダイアログ表示フラグもfalseにする
     */
    public func updateNotificationPermissionRequested() {
        Task {
            updateNotificationPermissionRequestedUseCase.invoke()
            
            uiState = SearchVideoUiState(
                isLoading: uiState.isLoading,
                query: uiState.query,
                videos: uiState.videos,
                errorMessage: uiState.errorMessage,
                showNotificationPermissionDialog: false
            )
        }
    }
}
