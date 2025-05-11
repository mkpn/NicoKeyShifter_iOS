//
//  VideoMapper.swift
//  NicoKeyShifter_iOS
//
//  Created by Devin AI on 2025/05/11.
//

import Foundation

public struct VideoMapper {
    public static func toVideoDomainModel(_ video: Video) -> VideoDomainModel {
        return VideoDomainModel(
            id: video.contentId,
            title: video.title,
            viewCount: video.viewCounter,
            thumbnailUrl: video.thumbnailUrl
        )
    }
}
