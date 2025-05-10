import Foundation
import Factory
import SwiftData

public extension Container {
    var itemDataSource: Factory<ItemDataSource & Sendable> {
        self {
            ItemDataSourceImpl()
        }
    }
}

public protocol ItemDataSource {
    func getAll() async -> [Item]
    func add(_ item: Item) async
    func delete(_ item: Item) async
    func deleteAll() async
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
    
    public func getAll() async -> [Item] {
        let descriptor = FetchDescriptor<Item>()
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            fatalError("\(error)")
        }
    }
    
    public func add(_ item: Item) async {
        modelContext.insert(item)
        do {
            try modelContext.save()
        } catch {
            fatalError("\(error)")
        }
    }
    
    public func delete(_ item: Item) async {
        modelContext.delete(item)
        do {
            try modelContext.save()
        } catch {
            fatalError("\(error)")
        }
    }
    
    public func deleteAll() async {
        do {
            let items = try await getAll()
            items.forEach { modelContext.delete($0) }
            try modelContext.save()
        } catch {
            fatalError("\(error)")
        }
    }
} 
