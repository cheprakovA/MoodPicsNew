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
    
    var degree = 0.0
    
    let moodLevels = [
        "POSITIVE",
        "CHEERY",
        "NEUTRAL",
        "SAD",
        "NEGATIVE"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func configureTableView() {
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableSegue" {
            if let indexPath = categoriesTableView.indexPathForSelectedRow {
                let destinationVC = segue.destination as! PhotoViewController
                destinationVC.degree = Double(20 * indexPath.item + 10)
            }
        }
    }
    
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = UIColor.black
        cell.configureCell(title: moodLevels[indexPath.item], imageName: moodLevels[indexPath.item].lowercased())
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.visibleSize.height / 5.0
    }
    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "TableSegue", sender: self)
    }
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

