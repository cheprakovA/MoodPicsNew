//
//  PhotoViewController.swift
//  MoodPics
//
//  Created by Artemy Cheprakov on 17/08/2019.
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    let viewModel = ViewModel(client: UnsplashClient())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = collectionView.collectionViewLayout as? CustomLayout {
            layout.delegate = self
        }
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        viewModel.showLoading = {
            if self.viewModel.isLoading  {
                self.activityIndicator.startAnimating()
                self.collectionView.alpha = 0.0
            } else {
                self.activityIndicator.stopAnimating()
                self.collectionView.alpha = 1.0
            }
        }
        
        viewModel.showError = { error in
            print(error)
        }

        viewModel.reloadData = {
            self.collectionView.reloadData()
        }
        
        viewModel.fetchPhotos()
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation override
     //func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    // }


}

// MARK: Flow layout delegate

extension PhotoViewController: CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let image = viewModel.cellViewModels[indexPath.item].image
        let height = image.size.height
        
        return height
    }
}

// MARK: Data source

extension PhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        
        let image = viewModel.cellViewModels[indexPath.item].image
        cell.imageView.image = image
        
        return cell
    }
}
