import Foundation

public struct SearchResponse: Codable {
    let meta: Meta
    let data: [Video]
    
    struct Meta: Codable {
        let status: Int
        let totalCount: Int
        
        enum CodingKeys: String, CodingKey {
            case status
            case totalCount = "total_count"
        }
    }
    
    public struct Video: Codable {
        let contentId: String
        let title: String
        let description: String
        let viewCount: Int
        let mylistCount: Int
        let commentCount: Int
        let startTime: String
        let thumbnailUrl: String
        
        enum CodingKeys: String, CodingKey {
            case contentId = "content_id"
            case title
            case description
            case viewCount = "view_count"
            case mylistCount = "mylist_count"
            case commentCount = "comment_count"
            case startTime = "start_time"
            case thumbnailUrl = "thumbnail_url"
        }
    }
} 
