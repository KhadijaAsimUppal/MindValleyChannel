//
//  MainViewController.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 04/11/2024.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    @IBOutlet weak var contentTableView: UITableView!
    
    private var viewModel = MindValleyMainViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentTableView.register(UINib(nibName: "EpisodeTableViewCell", bundle: nil), forCellReuseIdentifier: "EpisodeTableViewCell")
//        contentTableView.register(UINib(nibName: "ChannelTableViewCell", bundle: nil), forCellReuseIdentifier: "ChannelTableViewCell")
//        contentTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryCell")
        
        // Fetch data
        viewModel.fetchEpisodes()
        viewModel.fetchChannels()
        viewModel.fetchCategories()
        
        // Observe data changes
        viewModel.$episodes
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.contentTableView.reloadData() }
            .store(in: &cancellables)
        
        viewModel.$channels
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.contentTableView.reloadData() }
            .store(in: &cancellables)
        
        viewModel.$categories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.contentTableView.reloadData() }
            .store(in: &cancellables)
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ContentSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let contentSection = ContentSection(rawValue: section) else { return 0 }
        
        switch contentSection {
        case .episodes:
            return 1 // Single cell with a collection view inside for episodes
        case .channels:
            return viewModel.channels.count // Each channel is a separate row
        case .categories:
            return viewModel.categories.count // Each category is a separate row
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let contentSection = ContentSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch contentSection {
        case .episodes:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell", for: indexPath) as! EpisodeTableViewCell
            cell.configureCell(with: viewModel.episodes) // Configure collection view in the cell
            return cell
        default:
            return UITableViewCell()
//        case .channels:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelTableViewCell", for: indexPath) as! ChannelTableViewCell
//            let channel = viewModel.channels[indexPath.row]
//            cell.configure(with: channel)
//            return cell
//        case .categories:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
//            let category = viewModel.categories[indexPath.row]
//            cell.textLabel?.text = category.name
//            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ContentSection(rawValue: section)?.title
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let contentSection = ContentSection(rawValue: indexPath.section) else { return UITableView.automaticDimension }
        
        switch contentSection {
        case .episodes:
            return 354 // Set appropriate height for the collection view cell
        case .channels:
            return 100 // Set height for each channel row
        case .categories:
            return 50 // Set height for each category row
        }
    }
}


enum ContentSection: Int, CaseIterable {
    case episodes = 0
    case channels
    case categories
    
    var title: String {
        switch self {
        case .episodes:
            return "New Episodes"
        case .channels:
            return "Channels"
        case .categories:
            return "Categories"
        }
    }
}
