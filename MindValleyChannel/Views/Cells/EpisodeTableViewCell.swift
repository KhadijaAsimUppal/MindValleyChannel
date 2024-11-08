//
//  EpisodeTableViewCell.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 04/11/2024.
//
import UIKit

class EpisodeTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var episodes: [EpisodeModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "EpisodeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EpisodeCollectionViewCell")
    }
    
    func configureCell(with episodes: [EpisodeModel]) {
        //Limit to 6 items
        self.episodes = Array(episodes.prefix(6))
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodeCollectionViewCell", for: indexPath) as! EpisodeCollectionViewCell
        let episode = episodes[indexPath.item]
        cell.configure(title: episode.title,
                       subtitle: episode.channel.title,
                       imageUrl: episode.coverAsset.url
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: 168, height: 320)
        let width = collectionView.bounds.width / 2.4
        return CGSize(width: width, height: width * 1.8)
    }
}
