//
//  FirstViewController.swift
//  MoodPics
//
//  Created by Artemy Cheprakov on 13/08/2019.
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit

enum moodLevel: String {
    case negative = "negative"
    case sad = "sad"
    case neutral = "neutral"
    case cheery = "cheery"
    case positive = "positive"
}

class CategoriesViewController: UIViewController {

    @IBOutlet weak var categoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0: cell.configureTitle(title: moodLevel.negative.rawValue)
        case 1: cell.configureTitle(title: moodLevel.sad.rawValue)
        case 2: cell.configureTitle(title: moodLevel.neutral.rawValue)
        case 3: cell.configureTitle(title: moodLevel.cheery.rawValue)
        case 4: cell.configureTitle(title: moodLevel.positive.rawValue)
        default: cell.configureTitle(title: "error")
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.visibleSize.height / 5.0
    }
    
    func configureTableView() {
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        categoriesTableView.register(UINib.init(nibName: "CategoryTableViewCell", bundle: nil),  forCellReuseIdentifier: "CategoryTableViewCell")
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

