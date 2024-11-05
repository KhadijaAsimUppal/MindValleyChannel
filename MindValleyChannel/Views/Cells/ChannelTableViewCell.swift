//
//  ChannelTableViewCell.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 05/11/2024.
//

import UIKit

class ChannelTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var episodeCountLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    private var latestMedia: [CourseModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "EpisodeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EpisodeCollectionViewCell")
    }
    
    func configure(with channel: ChannelModel) {
        titleLabel.text = channel.title
        episodeCountLabel.text = "\(channel.mediaCount) episodes"
        iconImageView.image = UIImage(named: "thumbnailPlaceholderImage")
        
        // Load the channel icon if it exists
        if let thumbnailUrl = channel.iconAsset?.thumbnailUrl, let url = URL(string: thumbnailUrl) {
            // Load image asynchronously
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.iconImageView.image = image
                        self.collectionView.reloadData()
                    }
                }
            }.resume()
        }
        
        // Update latestMedia based on channel's latestMedia or series
        self.latestMedia = channel.latestMedia
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension ChannelTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return latestMedia.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodeCollectionViewCell", for: indexPath) as? EpisodeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let media = latestMedia[indexPath.item]
        cell.configure(title: media.title,
                       subtitle: nil,
                       imageUrl: media.coverAsset.url)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ChannelTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2.4
        return CGSize(width: width, height: width * 1.8)
        //return CGSize(width: 168, height: 370)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 4 // Vertical spacing between cells
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 4 // Horizontal spacing between cells
//    }
}
