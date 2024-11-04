//
//  RowfooterLineView.swift
//  MindValleyChannel
//
//  Created by Khadija Asim on 05/11/2024.
//


//class RowFooterLineView: UIView {
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupView()
//    }
//    
//    private func setupView() {
//        // Set the background color of the footer line, adjust color as needed
//        backgroundColor = UIColor(named: ColorConstants.mvSecondaryGrey.rawValue) ?? .lightGray
//        translatesAutoresizingMaskIntoConstraints = false
//    }
//}

import UIKit

class RowFooterLineView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: ColorConstants.mvSecondaryGrey.rawValue) ?? UIColor.systemGray
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor(named: ColorConstants.mvSecondaryGrey.rawValue) ?? UIColor.systemGray
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
