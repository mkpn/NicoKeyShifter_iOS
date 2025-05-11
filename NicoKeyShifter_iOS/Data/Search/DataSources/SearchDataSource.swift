//
//  SearchDataSource.swift
//  NicoKeyShifter_iOS
//
//  Created by 吉田誠 on 2025/05/11.
//

import Foundation
import Alamofire
import Factory

public extension Container {
    var searchDataSource: Factory<SearchDataSource & Sendable> {
        self {
            SearchDataSourceImpl()
        }
    }
}

public protocol SearchDataSource {
    func search(query: String) async throws -> SearchResponse
}

class SearchDataSourceImpl: SearchDataSource {
    private let baseURL = "https://api.search.nicovideo.jp/api/v2/video/contents/search"
    
    func search(query: String) async throws -> SearchResponse {
        let parameters: [String: Any] = [
            "q": query,
            "targets": "title,description,tags",
            "fields": "contentId,title,description,viewCount,mylistCount,commentCount,startTime,thumbnailUrl",
            "_sort": "-viewCount",
            "_limit": 20
        ]
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(baseURL, parameters: parameters)
                .validate()
                .responseDecodable(of: SearchResponse.self) { response in
                    switch response.result {
                    case .success(let searchResponse):
                        continuation.resume(returning: searchResponse)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
