//
//
//

import Foundation

public struct VideoDomainModel: Equatable {
    public let id: String
    public let title: String
    public let viewCount: Int
    public let thumbnailUrl: String
    
    public init(id: String, title: String, viewCount: Int, thumbnailUrl: String) {
        self.id = id
        self.title = title
        self.viewCount = viewCount
        self.thumbnailUrl = thumbnailUrl
    }
    
    public static func ofDefault() -> VideoDomainModel {
        return VideoDomainModel(
            id: "sm12345678",
            title: "サンプル動画タイトル",
            viewCount: 12345,
            thumbnailUrl: ""
        )
    }
}
