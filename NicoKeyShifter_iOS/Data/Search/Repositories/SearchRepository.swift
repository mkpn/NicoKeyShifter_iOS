import Foundation
import Factory

public extension Container {
    var searchRepository: Factory<SearchRepository> {
        self {
            SearchRepositoryImpl(dataSource: self.searchDataSource())
        }
    }
}

public protocol SearchRepository {
    func search(query: String, targets: String, sort: String, limit: Int) async throws -> SearchResponse
}

public final class SearchRepositoryImpl: SearchRepository {
    @Injected(\.searchDataSource) private var searchDataSource
    
    public init(dataSource: SearchDataSource) {
        self.searchDataSource = dataSource
    }

    public func search(query: String, targets: String = "title", sort: String = "-viewCounter", limit: Int = 100) async throws -> SearchResponse {
        try await searchDataSource.search(query: query, targets: targets, sort: sort, limit: limit)
    }
}  
