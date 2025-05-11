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
    func search(query: String, targets: String, sort: String, limit: Int) async throws -> SearchResponse
}

class SearchDataSourceImpl: SearchDataSource {
    private let baseURL = "https://snapshot.search.nicovideo.jp/api/v2/snapshot/video/contents/search"

    // 一貫した User-Agent 設定（Safari/iOS風）
    private let headers: HTTPHeaders = [
        "User-Agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1"
    ]

    func search(query: String, targets: String = "title", sort: String = "-viewCounter", limit: Int = 100) async throws -> SearchResponse {
        let parameters: [String: Any] = [
            "q": query,
            "targets": targets,
            "fields": "contentId,title,viewCounter,thumbnailUrl",
            "_sort": sort,
            "_limit": limit
        ]
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(baseURL, parameters: parameters, headers: headers)
                .validate()
                .cURLDescription { description in
                    print("📡 cURL:\n\(description)")
                }
                .responseDecodable(of: SearchResponse.self) { response in
                    switch response.result {
                    case .success(let responseValue):
                        print("✅ Success: \(responseValue)")
                        continuation.resume(returning: responseValue)
                    case .failure(let error):
                        print("❌ Error: \(error)")
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
