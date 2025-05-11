//
//  SearchVideoUseCase.swift
//  NicoKeyShifter_iOS
//
//  Created by Devin AI on 2025/05/11.
//

import Foundation
import Factory
import Combine

/**
 * 動画検索を行うユースケースクラス
 */
public class SearchVideoUseCase {
    @Injected(\.searchRepository) private var searchRepository
    
    public init() {}
    
    /**
     * キーワードで動画を検索する
     *
     * @param query 検索キーワード
     * @param targets 検索対象（デフォルトはタイトル）
     * @param sort ソート方法（デフォルトは再生数降順）
     * @param limit 取得件数（デフォルトは100件）
     * @return 検索結果のPublisher
     * @throws SearchException 検索に失敗した場合
     */
    public func invoke(
        query: String,
        targets: String = "title",
        sort: String = "-viewCounter",
        limit: Int = 100
    ) -> AnyPublisher<[VideoDomainModel], Error> {
        return Future<[VideoDomainModel], Error> { promise in
            Task {
                do {
                    let response = try await self.searchRepository.searchVideos(
                        query: query,
                        targets: targets,
                        sort: sort,
                        limit: limit
                    )
                    
                    // 取得した動画リストをVideoMapperを使って変換
                    let videos = response.data.map { video in
                        VideoMapper.toVideoDomainModel(video)
                    }
                    
                    promise(.success(videos))
                } catch {
                    if let searchError = error as? SearchException {
                        promise(.failure(searchError))
                    } else {
                        promise(.failure(SearchException.unexpectedError(error: error)))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
