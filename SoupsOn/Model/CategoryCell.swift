//
//  CategoryCell.swift
//  SoupsOn
//
//  Created by Chris Yan on 2022-03-25.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    func updateView(category: Category) {
        categoryImage.image = category.image
        categoryName.text = category.name
    }
    
}

struct Category {
    var image: UIImage?
    var name: String
}
