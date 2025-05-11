//
//  SearchVideoResponse.swift
//  NicoKeyShifter_iOS
//
//  Created by Devin AI on 2025/05/11.
//

import Foundation

public struct SearchVideoResponse: Codable {
    public let data: [Video]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}
