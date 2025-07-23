import Foundation
import Factory
import SwiftData

public extension Container {
    var favoriteVideoDataSource: Factory<FavoriteVideoDataSource & Sendable> {
        self {
            FavoriteVideoDataSourceImpl()
        }
    }
}

public protocol FavoriteVideoDataSource {
    func getAll() async -> [FavoriteVideo]
    func getById(_ videoId: String) async -> FavoriteVideo?
    func add(_ favoriteVideo: FavoriteVideo) async
    func delete(_ favoriteVideo: FavoriteVideo) async
    func deleteById(_ videoId: String) async
    func isFavorite(_ videoId: String) async -> Bool
}

@ModelActor
public actor FavoriteVideoDataSourceImpl: FavoriteVideoDataSource {
    
    public init() {
        do {
            let config = ModelConfiguration(for: FavoriteVideo.self, isStoredInMemoryOnly: false)
            let container = try ModelContainer(for: FavoriteVideo.self, configurations: config)
            let context = ModelContext(container)
            modelContainer = container
            modelExecutor = DefaultSerialModelExecutor(modelContext: context)
        } catch {
            fatalError("\(error)")
        }
    }
    
    public func getAll() async -> [FavoriteVideo] {
        let descriptor = FetchDescriptor<FavoriteVideo>()
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            fatalError("\(error)")
        }
    }
    
    public func getById(_ videoId: String) async -> FavoriteVideo? {
        let descriptor = FetchDescriptor<FavoriteVideo>()
        do {
            let allFavorites = try modelContext.fetch(descriptor)
            return allFavorites.first { $0.videoId == videoId }
        } catch {
            fatalError("\(error)")
        }
    }
    
    public func add(_ favoriteVideo: FavoriteVideo) async {
        modelContext.insert(favoriteVideo)
        do {
            try modelContext.save()
        } catch {
            fatalError("\(error)")
        }
    }
    
    public func delete(_ favoriteVideo: FavoriteVideo) async {
        modelContext.delete(favoriteVideo)
        do {
            try modelContext.save()
        } catch {
            fatalError("\(error)")
        }
    }
    
    public func deleteById(_ videoId: String) async {
        if let favoriteVideo = await getById(videoId) {
            await delete(favoriteVideo)
        }
    }
    
    public func isFavorite(_ videoId: String) async -> Bool {
        let favoriteVideo = await getById(videoId)
        return favoriteVideo != nil
    }
}
