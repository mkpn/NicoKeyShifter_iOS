import Foundation
import SwiftData

@Model
public final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
} 
