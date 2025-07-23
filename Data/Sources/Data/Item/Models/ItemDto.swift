import Foundation
import SwiftData

public struct ItemDto: Sendable {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
} 
