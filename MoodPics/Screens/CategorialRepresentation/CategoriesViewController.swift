//
//  FirstViewController.swift
//  MoodPics
//
//  Created by Artemy Cheprakov on 13/08/2019.
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var categoriesTableView: UITableView!
    
    let moodLevels = [
        "negative",
        "sad",
        "neutral",
        "cheery",
        "positive"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func configureTableView() {
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
    }
    
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(title: moodLevels[indexPath.item], imageName: moodLevels[indexPath.item])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.visibleSize.height / 5.0
    }
    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "ShowPicsController")
        self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

