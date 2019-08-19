//
//  CategoryViewCellTableViewCell.swift
//  MoodPics
//
//  Created by Artemy Cheprakov on 14/08/2019.
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var moodLevel: UILabel!
    @IBOutlet weak var emotion: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
        
    }
    
    func configure() {
        moodLevel.font = UIFont(name: "Comfortaa-Bold", size: ceil(moodLevel.bounds.width / 6.5))
        moodLevel.textColor = UIColor.black
        moodLevel.text = nil
        emotion.image = nil
    }
    
    func configureCell(title: String, imageName: String) {
        moodLevel.text = title
        emotion.image = UIImage(named: imageName)
    }
}
