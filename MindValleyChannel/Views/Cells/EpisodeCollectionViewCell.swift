//
//  EpisodeCollectionViewCell.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 04/11/2024.
//

import UIKit

class EpisodeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Additional customization if needed
        episodeImageView.contentMode = .scaleAspectFill
        episodeImageView.layer.cornerRadius = 8
        episodeImageView.clipsToBounds = true
    }
    
    // Configure the cell with episode data
    func configure(title: String, subtitle: String?, imageUrl: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle

        loadImage(for: imageUrl) { [weak self] image in
            self?.episodeImageView.image = image
        }
    }
    
    /// Loads an image from a given URL string, with a fallback to Core Data cache if network loading fails.
    /// - Parameters:
    ///   - urlString: The URL string of the image to load.
    ///   - completion: A closure that returns the loaded `UIImage?` on the main thread.
    /// This method attempts to download the image from the specified URL. If successful, the image data
    /// is saved to Core Data cache for future use. In case of a network failure, it retrieves the image
    /// from the Core Data cache if available.
    private func loadImage(for urlString: String, completion: @escaping (UIImage?) -> Void) {
        // Attempt to download image
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                // Successfully downloaded the image; save it to cache and return
                CoreDataManager.shared.saveImage(url: urlString, data: data)
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            } else if let cachedData = CoreDataManager.shared.fetchImage(url: urlString), let cachedImage = UIImage(data: cachedData) {
                // Network request failed; fetch image from cache if available
                DispatchQueue.main.async {
                    completion(cachedImage)
                }
            } else {
                // If no image is available in cache either, return nil
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }


}
