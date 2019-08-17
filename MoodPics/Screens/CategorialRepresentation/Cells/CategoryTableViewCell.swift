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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
        
    }
    
    func configure() {
        moodLevel.font = UIFont(name: "AA-Batho", size: 80)
        moodLevel.textColor = UIColor.black
        moodLevel.text = nil
    }
    
    func configureTitle(title: String) {
        moodLevel.text = title
    }
}
