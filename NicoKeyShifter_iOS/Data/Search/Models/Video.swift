//
//  Video.swift
//  NicoKeyShifter_iOS
//
//  Created by Devin AI on 2025/05/11.
//

import Foundation

public struct Video: Codable {
    public let contentId: String
    public let title: String
    public let viewCounter: Int
    public let thumbnailUrl: String
    
    enum CodingKeys: String, CodingKey {
        case contentId
        case title
        case viewCounter
        case thumbnailUrl
    }
}
