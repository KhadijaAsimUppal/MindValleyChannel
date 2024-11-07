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
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// MARK: - Saving Methods
extension CoreDataManager {
    
    func saveEpisode(_ episode: EpisodeModel) {
        // Fetch an existing episode with the same title
        let fetchRequest: NSFetchRequest<CachedEpisodeModel> = CachedEpisodeModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", episode.title)
        
        do {
            if let existingEpisode = try context.fetch(fetchRequest).first {
                // If an episode with the same title exists, update its properties
                existingEpisode.type = episode.type
                existingEpisode.channelTitle = episode.channel.title
                existingEpisode.coverAssetUrl = episode.coverAsset.url
                print("Updated existing episode with title: \(episode.title)")
            } else {
                // If no episode with the same title exists, create a new one
                let cachedEpisode = CachedEpisodeModel(context: context)
                cachedEpisode.title = episode.title
                cachedEpisode.type = episode.type
                cachedEpisode.channelTitle = episode.channel.title
                cachedEpisode.coverAssetUrl = episode.coverAsset.url
                print("Saved new episode with title: \(episode.title)")
            }
            saveContext()  // Save changes to Core Data
        } catch {
            print("Failed to save or update episode: \(error)")
        }
    }
    
    
    func saveImage(url: String, data: Data) {
          // Fetch an existing image with the same URL
          let fetchRequest: NSFetchRequest<CachedImage> = CachedImage.fetchRequest()
          fetchRequest.predicate = NSPredicate(format: "url == %@", url)
          
          do {
              if let existingImage = try context.fetch(fetchRequest).first {
                  // If an image with the same URL exists, update its data
                  existingImage.data = data
                  print("Updated existing image with URL: \(url)")
              } else {
                  // If no image with the same URL exists, create a new one
                  let cachedImage = CachedImage(context: context)
                  cachedImage.url = url
                  cachedImage.data = data
                  print("Saved new image with URL: \(url)")
              }
              saveContext()  // Save changes to Core Data
          } catch {
              print("Failed to save or update image: \(error)")
          }
      }
}

// MARK: - Fetching Methods
extension CoreDataManager {
    
    func fetchEpisodes() -> [EpisodeModel] {
        let fetchRequest: NSFetchRequest<CachedEpisodeModel> = CachedEpisodeModel.fetchRequest()
        do {
            let cachedEpisodes = try context.fetch(fetchRequest)
            return cachedEpisodes.map { cachedEpisode in
                EpisodeModel(
                    type: "CACHED: \(cachedEpisode.type)",
                    title: "CACHED: \(cachedEpisode.title)",
                    coverAsset: CoverAssetModel(url: cachedEpisode.coverAssetUrl),
                    channel: ChannelInfoModel(title: "CACHED: \(cachedEpisode.channelTitle)")
                )
            }
        } catch {
            print("Failed to fetch episodes: \(error)")
            return []
        }
    }
    
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
