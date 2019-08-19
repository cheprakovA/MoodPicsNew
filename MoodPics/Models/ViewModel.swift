//
//  ViewModel.swift
//  MoodPics
//
//  Created by Artemy Cheprakov on 17/08/2019.
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit
import Foundation

struct CellViewModel {
    let image: UIImage
}

class ViewModel {
    
    // MARK: Properties
    
    let ptr = Prediction()
    
    private let client: APICLient
    private var photos: Photos = [] {
        didSet {
            self.fetchPhoto()
        }
    }
    
    var cellViewModels: [CellViewModel] = []
    
    var degree = 0.0
    var degrees = [Double]()
    
    var low = 0.0, high = 0.0
    
    // MARK: UI
    
    var isLoading: Bool = false {
        didSet {
            showLoading?()
        }
    }
    
    var showLoading: (() -> Void)?
    var reloadData: (() -> Void)?
    var showError: ((Error) -> Void)?
    
    init(client: APICLient) {
        self.client = client
    }
    
    func fetchPhotos() {
        if let client = client as? UnsplashClient {
            self.isLoading = true
            let endpoint = UnsplashEndpoint.photos(id: NetworkConstants.accessKey, order: .popular)
            client.fetch(with: endpoint) { (either) in
                switch either {
                case .success(let photos):
                    self.photos = photos
                case .error(let error):
                    self.showError?(error)
                }
            }
        }
    }
    
    private func fetchPhoto() {
        let group = DispatchGroup()
        self.photos.forEach { (photo) in
            DispatchQueue.global(qos: .background).async(group: group) {
                
                group.enter()
                guard let imageData = try? Data(contentsOf: photo.urls.small) else {
                    self.showError?(APIError.imageDownload)
                    return
                }
                guard let image = UIImage(data: imageData) else {
                    self.showError?(APIError.imageConvert)
                    return
                }
                self.degree = self.ptr.predict(image: image)
                
                if self.degree >= self.low && self.degree <= self.high {
                    self.cellViewModels.append(CellViewModel(image: image))
                    self.degrees.append(self.degree)
                }
                group.leave()
                
            }
        }
        group.notify(queue: .main) {
            self.isLoading = false
            self.reloadData?()
        }
    }
    
}
