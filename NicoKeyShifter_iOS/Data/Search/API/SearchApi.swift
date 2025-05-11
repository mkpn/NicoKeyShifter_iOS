//
//  SearchApi.swift
//  NicoKeyShifter_iOS
//
//  Created by Devin AI on 2025/05/11.
//

import Foundation
import Alamofire

public protocol SearchApi {
    func search(
        query: String,
        targets: String,
        fields: String,
        sort: String,
        limit: Int
    ) async throws -> SearchVideoResponse
}

public class SearchApiImpl: SearchApi {
    private let baseURL = "https://api.search.nicovideo.jp"
    
    public init() {}
    
    public func search(
        query: String,
        targets: String = "title",
        fields: String = "contentId,title,viewCounter,thumbnailUrl",
        sort: String = "-viewCounter",
        limit: Int = 100
    ) async throws -> SearchVideoResponse {
        let url = "\(baseURL)/video/contents/search"
        
        let parameters: [String: Any] = [
            "q": query,
            "targets": targets,
            "fields": fields,
            "_sort": sort,
            "_limit": limit
        ]
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, parameters: parameters)
                .validate()
                .responseDecodable(of: SearchVideoResponse.self) { response in
                    switch response.result {
                    case .success(let searchResponse):
                        continuation.resume(returning: searchResponse)
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode {
                            continuation.resume(throwing: SearchException.apiError(statusCode: statusCode))
                        } else {
                            continuation.resume(throwing: SearchException.unexpectedError(error: error))
                        }
                    }
                }
        }
    }
}
