//
//  CategoryTableViewCell.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 05/11/2024.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    private var categories: [CategoryModel] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: ViewIdConstants.categoryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ViewIdConstants.categoryCollectionViewCell)
    }

    func configure(with categories: [CategoryModel]) {
        self.categories = categories
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension CategoryTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewIdConstants.categoryCollectionViewCell, for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let category = categories[indexPath.item]
        cell.configure(with: category.name)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width / 2) - 16 // Adjust for spacing
        return CGSize(width: width, height: 50) // Set height for category buttons
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8) // Adjust left and right padding as needed
    }
}
