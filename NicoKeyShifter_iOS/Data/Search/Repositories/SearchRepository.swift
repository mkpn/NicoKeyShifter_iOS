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
    func search(query: String, targets: String, sort: String, limit: Int) async throws -> SearchResponse
}

public final class SearchRepositoryImpl: SearchRepository {
    private let dataSource: SearchDataSource
    
    public init(dataSource: SearchDataSource) {
        self.dataSource = dataSource
    }
    
    public func search(query: String, targets: String = "title", sort: String = "-viewCounter", limit: Int = 100) async throws -> SearchResponse {
        try await dataSource.search(query: query, targets: targets, sort: sort, limit: limit)
    }
}  
