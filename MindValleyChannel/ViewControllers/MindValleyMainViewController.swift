//
//  ViewController.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 02/11/2024.
//

import UIKit
import Combine

class MindValleyMainViewController: UIViewController {
    
    private var viewModel = MindValleyMainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch episodes
        viewModel.fetchEpisodes()
        
        // Fetch channels
        viewModel.fetchChannels()
        
        // Fetch categories
        viewModel.fetchCategories()
    }
}

