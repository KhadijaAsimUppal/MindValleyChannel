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
    func configure(with episode: EpisodeModel) {
        titleLabel.text = episode.title
        subtitleLabel.text = episode.channel.title
        
        // Assuming that you have an `url` in your model and use a placeholder image
        // Load image asynchronously
        let urlString = episode.coverAsset.url
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.episodeImageView.image = image
                    }
                }
            }.resume()
        }
    }
}
