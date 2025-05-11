//
//
//

import Foundation
import Factory
import SwiftUI
import Domain

@MainActor
public class SearchViewModel: ObservableObject {
    @Injected(\.searchVideoUseCase) private var searchVideoUseCase
    
    @Published private(set) var uiState = SearchVideoUiState()
    
    public init() {}
    
    public func search(
        query: String,
        targets: String = "title",
        sort: String = "-viewCounter",
        limit: Int = 100
    ) {
        if query.isEmpty {
            uiState = SearchVideoUiState()
            return
        }
        
        uiState = SearchVideoUiState(
            isLoading: true,
            query: query,
            videos: [],
            errorMessage: nil
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
                    errorMessage: nil
                )
            } catch {
                let errorMessage = "検索中にエラーが発生しました: \(error.localizedDescription)"
                uiState = SearchVideoUiState(
                    isLoading: false,
                    query: query,
                    videos: [],
                    errorMessage: errorMessage
                )
            }
        }
    }
    
    public func clearSearch() {
        uiState = SearchVideoUiState()
    }
}
