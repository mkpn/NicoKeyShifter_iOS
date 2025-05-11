//
//
//

import Foundation

public enum VideoMapper {
    public static func toVideoDomainModel(video: SearchResponse.Video) -> VideoDomainModel {
        return VideoDomainModel(
            id: video.contentId,
            title: video.title,
            viewCount: video.viewCount,
            thumbnailUrl: video.thumbnailUrl
        )
    }
}
