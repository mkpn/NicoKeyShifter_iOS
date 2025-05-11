//
//  SearchRepository.swift
//  NicoKeyShifter_iOS
//
//  Created by Devin AI on 2025/05/11.
//

import Foundation
import Factory

public extension Container {
    var searchRepository: Factory<SearchRepository & Sendable> {
        self {
            SearchRepositoryImpl()
        }
    }
}

public protocol SearchRepository {
    func searchVideos(
        query: String,
        targets: String,
        sort: String,
        limit: Int
    ) async throws -> SearchVideoResponse
}

public final class SearchRepositoryImpl: SearchRepository, Sendable {
    let dataSource = Container.shared.searchDataSource()
    
    public init() {}
    
    public func searchVideos(
        query: String,
        targets: String = "title",
        sort: String = "-viewCounter",
        limit: Int = 100
    ) async throws -> SearchVideoResponse {
        return try await dataSource.searchVideos(
            query: query,
            targets: targets,
            sort: sort,
            limit: limit
        )
    }
}
