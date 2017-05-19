//
//  TabCollectionViewCell.swift
//  Pods
//
//  Created by Jorge Miguel Lucena Pino on 19/05/2017.
//
//

import UIKit

class TabCollectionViewCell: UICollectionViewCell {
    
    // MARK: Static properties
    
    static let identifier = "TabCollectionViewCell"
    
    // MARK: Properties
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var selectedIndicator: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = !self.isSelected
        
        return imageView
    }()
    
    var summary: TabCollectionViewCellSummary? {
        didSet {
            imageView.image = summary?.icon.withRenderingMode(.alwaysTemplate)
            selectedIndicator.backgroundColor = summary?.selectionColor
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                imageView.tintColor = UIColor.white
            } else {
                imageView.tintColor = UIColor.gray
            }
            selectedIndicator.isHidden = !self.isSelected
        }
    }
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }
    
    func initializeView() {
        
        addSubview(imageView)
        addSubview(selectedIndicator)
        
        // Constraints
        let views = ["imageView": imageView, "selectedIndicator": selectedIndicator]
        let metrics = ["margin": 10, "indicatorHeight": 3]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-margin-[imageView]-margin-|", options: [], metrics: metrics, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-margin-[selectedIndicator]-margin-|", options: [], metrics: metrics, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-margin-[imageView]-(>=margin)-[selectedIndicator(==indicatorHeight)]|", options: [], metrics: metrics, views: views))
 
    }
}

struct TabCollectionViewCellSummary {
    let icon: UIImage
    let selectionColor: UIColor?
}