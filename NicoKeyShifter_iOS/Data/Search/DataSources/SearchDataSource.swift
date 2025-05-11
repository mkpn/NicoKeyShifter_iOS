//
//  SearchDataSource.swift
//  NicoKeyShifter_iOS
//
//  Created by Devin AI on 2025/05/11.
//

import Foundation
import Factory

public extension Container {
    var searchDataSource: Factory<SearchDataSource & Sendable> {
        self {
            SearchDataSourceImpl()
        }
    }
}

public protocol SearchDataSource {
    func searchVideos(
        query: String,
        targets: String,
        sort: String,
        limit: Int
    ) async throws -> SearchVideoResponse
}

public actor SearchDataSourceImpl: SearchDataSource {
    private let searchApi: SearchApi
    
    public init(searchApi: SearchApi = SearchApiImpl()) {
        self.searchApi = searchApi
    }
    
    public func searchVideos(
        query: String,
        targets: String = "title",
        sort: String = "-viewCounter",
        limit: Int = 100
    ) async throws -> SearchVideoResponse {
        return try await searchApi.search(
            query: query,
            targets: targets,
            fields: "contentId,title,viewCounter,thumbnailUrl",
            sort: sort,
            limit: limit
        )
    }
}
