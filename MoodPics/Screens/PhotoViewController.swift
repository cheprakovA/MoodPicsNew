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
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Properties

    var degree = 0.0
    var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lower = degree - 10.0, higher = degree + 10.0
        
        viewModel = ViewModel(client: UnsplashClient(), left: lower, right: higher)
        
        if let layout = collectionView.collectionViewLayout as? CustomLayout {
            layout.delegate = self
        }
        collectionView.backgroundColor = UIColor.black
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        viewModel?.showLoading = {
            if self.viewModel!.isLoading {
                self.activityIndicator.startAnimating()
                self.collectionView.alpha = 0.0
            } else {
                self.activityIndicator.stopAnimating()
                self.collectionView.alpha = 1.0
            }
        }
        
        viewModel?.showError = { error in
            print(error)
        }

        viewModel?.reloadData = {
            self.collectionView.reloadData()
        }
        
        viewModel?.fetchPhotos()
    }

}
  
// MARK: Flow layout delegate

extension PhotoViewController: CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        
        return viewModel!.cellViewModels[indexPath.item].image.size
    }
}

// MARK: Data source

extension PhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel!.cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        let image = viewModel?.cellViewModels[indexPath.item].image
        cell.imageView.image = image
        
        return cell
    }
}

