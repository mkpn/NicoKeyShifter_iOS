import Foundation
import Factory
import SwiftData


public extension Container {
    var itemRepository: Factory<ItemRepository & Sendable> {
        self {
            ItemRepositoryImpl()
        }
    }
}

public protocol ItemRepository {
}

public final class ItemRepositoryImpl: ItemRepository, Sendable {
    private let dataSource = Container.shared.itemDao
    
    public init(){}
    
    public func getAll() async throws -> [Item] {
        try await dataSource.getAll()
    }
    
    public func add(_ item: Item) async throws {
        try await dataSource.add(item)
    }
    
    public func delete(_ item: Item) async throws {
        try await dataSource.delete(item)
    }
    
    public func deleteAll() async throws {
        try await dataSource.deleteAll()
    }
} 
