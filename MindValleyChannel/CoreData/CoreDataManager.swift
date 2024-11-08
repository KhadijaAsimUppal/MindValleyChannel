//
//  CoreDataManager.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 06/11/2024.
//

import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private let saveQueue = DispatchQueue(label: "CoreDataSaveQueue")
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MindValleyChannel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        saveQueue.async { [weak self] in
            guard let self = self else { return }
            self.context.perform {
                if self.context.hasChanges {
                    do {
                        try self.context.save()
                        print("Context saved successfully.")
                    } catch {
                        print("Failed to save context: \(error)")
                    }
                }
            }
        }
    }
}

// MARK: - Methods for Saving and Fetching Episodes
extension CoreDataManager {
    
    /// Saves an episode to Core Data.
    /// If an episode with the same `title` already exists, the method does nothing.
    func saveEpisode(_ episode: EpisodeModel) {
        // Fetch an existing episode with the same title
        let fetchRequest: NSFetchRequest<CachedEpisodeModel> = CachedEpisodeModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", episode.title)
        
        do {
            // Check if the episode already exists
            if let _ = try context.fetch(fetchRequest).first {
                print("Episode with title: \(episode.title) already exists, skipping save.")
                return
            }
            
            // Create a new episode if it doesn't already exist
            let cachedEpisode = CachedEpisodeModel(context: context)
            cachedEpisode.title = episode.title
            cachedEpisode.type = episode.type
            cachedEpisode.channelTitle = episode.channel.title
            cachedEpisode.coverAssetUrl = episode.coverAsset.url
            
            try context.save() // Save the context after adding the episode
            print("Saved new episode with title: \(episode.title)")
            
        } catch {
            print("Failed to save or check for existing episode: \(error)")
        }
    }
 
    /// Fetch Eoisodes from Core Data if exists
    func fetchEpisodes() -> [EpisodeModel] {
        let fetchRequest: NSFetchRequest<CachedEpisodeModel> = CachedEpisodeModel.fetchRequest()
        do {
            let cachedEpisodes = try context.fetch(fetchRequest)
            return cachedEpisodes.map { cachedEpisode in
                EpisodeModel(
                    type: cachedEpisode.type,
                    title: cachedEpisode.title,
                    coverAsset: CoverAssetModel(url: cachedEpisode.coverAssetUrl),
                    channel: ChannelInfoModel(title: cachedEpisode.channelTitle)
                )
            }
        } catch {
            print("Failed to fetch episodes: \(error)")
            return []
        }
    }
    
}

// MARK: - Methods for Saving and Fetching Channels
extension CoreDataManager {
    
    /// Saves a channel with its series and courses to Core Data.
    /// If a channel with the same `id` already exists, the method does nothing.
    func saveChannel(_ channel: ChannelModel) {
        let fetchRequest: NSFetchRequest<CachedChannelModel> = CachedChannelModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", channel.id ?? "")
        
        do {
            // Check if the channel already exists
            if let _ = try context.fetch(fetchRequest).first {
                print("Channel with id: \(channel.id ?? "N/A") already exists, skipping save.")
                return
            }
            
            // If the channel doesn't exist, create a new one
            let cachedChannel = CachedChannelModel(context: context)
            cachedChannel.id = channel.id
            cachedChannel.title = channel.title
            cachedChannel.mediaCount = Int32(channel.mediaCount)
            cachedChannel.iconAssetUrl = channel.iconAsset?.thumbnailUrl
            cachedChannel.coverAsseturl = channel.coverAsset.url
            
            // Save Series within Channel
            if let seriesArray = channel.series {
                for series in seriesArray {
                    let cachedSeries = CachedSeriesModel(context: context)
                    cachedSeries.title = series.title
                    cachedSeries.coverAssetUrl = series.coverAsset.url
                    cachedChannel.addToSeries(cachedSeries)
                }
            }
            
            // Save Courses within Channel
            for course in channel.latestMedia {
                let cachedCourse = CachedCourseModel(context: context)
                cachedCourse.type = course.type
                cachedCourse.title = course.title
                cachedCourse.coverAssetModel = course.coverAsset.url
                cachedChannel.addToCourses(cachedCourse)
            }
            
            // Save only once after processing all entities
            try context.save()
            print("Saved new channel with title: \(channel.title)")
            
        } catch {
            print("Failed to save or check for existing channel: \(error)")
        }
    }
    
    /// Fetch channels from Core Data if exists
    func fetchChannels() -> [ChannelModel] {
        let fetchRequest: NSFetchRequest<CachedChannelModel> = CachedChannelModel.fetchRequest()
        
        do {
            let cachedChannels = try context.fetch(fetchRequest)
            return cachedChannels.map { cachedChannel in
                
                let series = (cachedChannel.series?.allObjects as? [CachedSeriesModel])?.map {
                    SeriesModel(title: $0.title, coverAsset: CoverAssetModel(url: $0.coverAssetUrl))
                }
                
                let courses = (cachedChannel.courses.allObjects as? [CachedCourseModel])?.map {
                    CourseModel(type: $0.type, title: $0.title, coverAsset: CoverAssetModel(url: $0.coverAssetModel))
                }
                
                return ChannelModel(title: "\(cachedChannel.title)",
                                    series: series,
                                    mediaCount: Int(cachedChannel.mediaCount),
                                    latestMedia: courses ?? [],
                                    id: cachedChannel.id,
                                    iconAsset: ThumbnailAssetModel(thumbnailUrl: cachedChannel.iconAssetUrl),
                                    coverAsset: CoverAssetModel(url: cachedChannel.coverAsseturl))
            }
        } catch {
            print("Failed to fetch channels: \(error)")
            return []
        }
    }
}

// MARK: - Methods for Saving and Fetching Categories
extension CoreDataManager {
    
    /// Saves a category to Core Data.
    /// If a category with the same name already exists, the method does nothing.
    func saveCategory(_ category: CategoryModel) {
        let fetchRequest: NSFetchRequest<CachedCategoryModel> = CachedCategoryModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", category.name)
        
        do {
            /// Check if category already exists
            if let _ = try context.fetch(fetchRequest).first {
                /// If the category with the same name already exists, do nothing
                print("Category with name: \(category.name) already exists, skipping save.")
                return
            }
            
            /// If category doesn't exist, create a new one
            let cachedCategory = CachedCategoryModel(context: context)
            cachedCategory.name = category.name
            
            try context.save()
            print("Saved new category with name: \(category.name)")
            
        } catch {
            print("Failed to save or check for existing category: \(error)")
        }
    }
    
    /// Fetch categories from Core Data if exists
    func fetchCategories() -> [CategoryModel] {
        let fetchRequest: NSFetchRequest<CachedCategoryModel> = CachedCategoryModel.fetchRequest()
        do {
            let cachedCategories = try context.fetch(fetchRequest)
            return cachedCategories.map { CategoryModel(name: $0.name ?? "") }
        } catch {
            print("Failed to fetch categories: \(error)")
            return []
        }
    }
}

// MARK: - Methods for Saving and Fetching Images
extension CoreDataManager {
    
    /// Saves  image with Url to Core Data
    func saveImage(url: String, data: Data) {
        /// Fetch an existing image with the same URL
        let fetchRequest: NSFetchRequest<CachedImage> = CachedImage.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "url == %@", url)
        
        do {
            if let _ = try context.fetch(fetchRequest).first {
                print("Image with URL: \(url) already exists")
                return
            } else {
                /// If no image with the same URL exists, create a new one
                let cachedImage = CachedImage(context: context)
                cachedImage.url = url
                cachedImage.data = data
            }
            
            saveContext()
            print("Saved new image with URL: \(url)")
            
        } catch {
            print("Failed to save or update image: \(error)")
        }
    }
    
    /// Fetch image from Core data is exists
    func fetchImage(url: String) -> Data? {
        let fetchRequest: NSFetchRequest<CachedImage> = CachedImage.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "url == %@", url)
        do {
            let cachedImages = try context.fetch(fetchRequest)
            return cachedImages.first?.data
        } catch {
            print("Failed to fetch image: \(error)")
            return nil
        }
    }
}
