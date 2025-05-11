import Foundation

public struct SearchResponse: Codable {
    let meta: Meta
    let data: [Video]
    
    struct Meta: Codable {
        let status: Int
    }

    public struct Video: Codable {
        let contentId: String
        let title: String
        let viewCounter: Int
        let thumbnailUrl: String
    }
} 
