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
        
        // Assuming that you have an `url` in your model and use a placeholder image
        // Load image asynchronously
        if let url = URL(string: imageUrl) {
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
