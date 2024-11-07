//
//  MainViewController.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 04/11/2024.
//

import UIKit
import Combine

class MindValleyMainViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var contentTableView: UITableView!
    
    // MARK: - Properties
    private var viewModel = MindValleyMainViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
        fetchData()
    }
}

// MARK: - Private Setup Methods
extension MindValleyMainViewController {
    
    /// Configures the table view with cell registrations.
    private func setupTableView() {
        contentTableView.register(UINib(nibName: "EpisodeTableViewCell", bundle: nil), forCellReuseIdentifier: "EpisodeTableViewCell")
        contentTableView.register(UINib(nibName: "ChannelTableViewCell", bundle: nil), forCellReuseIdentifier: "ChannelTableViewCell")
        contentTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
    }
    
    /// Binds the view model data updates to the view controller.
    private func bindViewModel() {
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
    
    /// Initiates data fetch from the view model.
    private func fetchData() {
        viewModel.fetchEpisodes()
        viewModel.fetchChannels()
        viewModel.fetchCategories()
    }
}

// MARK: - UITableViewDelegate
extension MindValleyMainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForSection(at: indexPath.section)
    }
}

// MARK: - UITableViewDataSource
extension MindValleyMainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let contentSection = ContentSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch contentSection {
        case .episodes:
            let cell = tableView.dequeueReusableCell(withIdentifier: ViewIdConstants.episodeTableViewCell, for: indexPath) as! EpisodeTableViewCell
            cell.configureCell(with: viewModel.episodes)
            addFooterLine(to: cell)
            return cell
        case .channels:
            let cell = tableView.dequeueReusableCell(withIdentifier: ViewIdConstants.channelTableViewCell, for: indexPath) as! ChannelTableViewCell
            let channel = viewModel.channels[indexPath.row]
            cell.configure(with: channel)
            addFooterLine(to: cell)
            return cell
        case .categories:
            let cell = tableView.dequeueReusableCell(withIdentifier: ViewIdConstants.categoryTableViewCell, for: indexPath) as! CategoryTableViewCell
            cell.configure(with: viewModel.categories)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createHeaderView(for: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightForHeader(in: section)
    }
}

// MARK: - Private Helpers
extension MindValleyMainViewController {
    
    /// Adds a custom footerline after each cell
    private func addFooterLine(to cell: UITableViewCell) {
        let footerLine = RowFooterLineView()
        cell.contentView.addSubview(footerLine)
        NSLayoutConstraint.activate([
            footerLine.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 8),
            footerLine.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -8),
            footerLine.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
            footerLine.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    /// Creates and configures the section header view based on the section.
    private func createHeaderView(for section: Int) -> UIView? {
        guard let contentSection = ContentSection(rawValue: section), contentSection != .channels else { return nil }
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor(named: ColorConstants.mvBackgroundGrey.rawValue)
        
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = contentSection.title
        headerLabel.font = UIFont(name: "Roboto-Bold", size: 17)
        headerLabel.textColor = UIColor(named: ColorConstants.mvSecondaryGrey.rawValue) ?? .systemGray
        
        headerView.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 12),
            headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -12),
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
        ])
        
        return headerView
    }
}
