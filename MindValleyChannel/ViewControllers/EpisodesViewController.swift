//
//  ViewController.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 02/11/2024.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private var viewModel = EpisodesViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch episodes
        viewModel.fetchEpisodes()
        
        // Fetch channels
        viewModel.fetchChannels()
    }
}

