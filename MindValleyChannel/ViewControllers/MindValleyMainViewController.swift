//
//  ViewController.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 02/11/2024.
//

import UIKit
import Combine

class MindValleyMainViewController: UIViewController {
    
    @IBOutlet weak var episodesCollectionView: UICollectionView!
    
    private var viewModel = MindValleyMainViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        episodesCollectionView.register(UINib(nibName: "EpisodeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EpisodeCollectionViewCell")
        
        // Fetch episodes
        viewModel.fetchEpisodes()
        viewModel.$episodes
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.episodesCollectionView.reloadData()
            }
            .store(in: &cancellables)
    }
}

// MARK: - UICollectionViewDataSource
extension MindValleyMainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodeCollectionViewCell", for: indexPath) as? EpisodeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let episode = viewModel.episodes[indexPath.item]
        cell.configure(with: episode)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MindValleyMainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Set your desired cell size here
        let width = collectionView.bounds.width / 2.4
        let height = width * 1.5 // Adjust height based on your design
        return CGSize(width: width, height: height)
    }
    
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 2
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 2
//    }
}
