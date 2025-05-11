import Foundation
import Factory

public extension Container {
    var searchRepository: Factory<SearchRepository & Sendable> {
        self {
            SearchRepositoryImpl(dataSource: self.searchDataSource())
        }
    }
}

public protocol SearchRepository {
    func search(query: String) async throws -> SearchResponse
}

public final class SearchRepositoryImpl: SearchRepository {
    private let dataSource: SearchDataSource
    
    public init(dataSource: SearchDataSource) {
        self.dataSource = dataSource
    }
    
    public func search(query: String) async throws -> SearchResponse {
        try await dataSource.search(query: query)
    }
} 
