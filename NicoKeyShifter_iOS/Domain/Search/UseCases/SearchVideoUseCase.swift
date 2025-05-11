//
//
//

import Foundation
import Factory

public extension Container {
    var searchVideoUseCase: Factory<SearchVideoUseCase & Sendable> {
        self {
            SearchVideoUseCaseImpl(searchRepository: self.searchRepository())
        }
    }
}

public protocol SearchVideoUseCase {
    /**
     * キーワードで動画を検索する
     *
     * @param query 検索キーワード
     * @param targets 検索対象（デフォルトはタイトル）
     * @param sort ソート方法（デフォルトは再生数降順）
     * @param limit 取得件数（デフォルトは100件）
     * @return 検索結果
     * @throws Error 検索に失敗した場合
     */
    func invoke(query: String, targets: String, sort: String, limit: Int) async throws -> [VideoDomainModel]
}

public final class SearchVideoUseCaseImpl: SearchVideoUseCase {
    private let searchRepository: SearchRepository
    
    public init(searchRepository: SearchRepository) {
        self.searchRepository = searchRepository
    }
    
    public func invoke(
        query: String,
        targets: String = "title",
        sort: String = "-viewCounter",
        limit: Int = 100
    ) async throws -> [VideoDomainModel] {
        let searchResponse = try await searchRepository.search(
            query: query,
            targets: targets,
            sort: sort,
            limit: limit
        )
        
        return searchResponse.data.map { video in
            VideoMapper.toVideoDomainModel(video: video)
        }
    }
}
