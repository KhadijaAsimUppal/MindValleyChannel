//
//  CategoryCollectionViewCell.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 05/11/2024.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.layer.cornerRadius = 24
        nameLabel.clipsToBounds = true
    }
    
    func configure(with title: String) {
        nameLabel.text = title
    }
}
