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
    func getAll() async -> [Item]
    func add(_ item: Item) async
    func delete(_ item: Item) async
    func deleteAll() async
}

public final class ItemRepositoryImpl: ItemRepository, Sendable {
    let dataSource = Container.shared.itemDataSource()
    
    public init(){}
    
    public func getAll() async -> [Item] {
        await dataSource.getAll()
    }
    
    public func add(_ item: Item) async {
        await dataSource.add(item)
    }
    
    public func delete(_ item: Item) async {
        await dataSource.delete(item)
    }
    
public func deleteAll() async {
        await dataSource.deleteAll()
    }
} 
