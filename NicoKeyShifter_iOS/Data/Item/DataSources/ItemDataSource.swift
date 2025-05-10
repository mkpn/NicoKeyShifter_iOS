import Foundation
import Factory
import SwiftData

public extension Container {
    var itemDao: Factory<ItemDataSource & Sendable> {
        self {
            ItemDataSourceImpl()
        }
    }
}

public protocol ItemDataSource {
    func getAll() async throws -> [Item]
    func add(_ item: Item) async throws
    func delete(_ item: Item) async throws
    func deleteAll() async throws
}

@ModelActor
public actor ItemDataSourceImpl: ItemDataSource {

    public init() {
        do {
            let config = ModelConfiguration(for: Item.self, isStoredInMemoryOnly: false)
            let container = try ModelContainer(for: Item.self, configurations: config)
            let context = ModelContext(container)
            modelContainer = container
            modelExecutor = DefaultSerialModelExecutor(modelContext: context)
        } catch {
            fatalError("\(error)")
        }
    }
    
    public func getAll() async throws -> [Item] {
        let descriptor = FetchDescriptor<Item>()
        return try modelContext.fetch(descriptor)
    }
    
    public func add(_ item: Item) async throws {
        modelContext.insert(item)
        try modelContext.save()
    }
    
    public func delete(_ item: Item) async throws {
        modelContext.delete(item)
        try modelContext.save()
    }
    
    public func deleteAll() async throws {
        let items = try await getAll()
        items.forEach { modelContext.delete($0) }
        try modelContext.save()
    }
} 
