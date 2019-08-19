//
//  File.swift
//  MoodPics
//
//  Created by Artemy Cheprakov on 19/08/2019.
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit
import Foundation
import Vision

class Prediction {
    
    static let trainedImageSize = CGSize(width: 227, height: 227)
    static let model = VisualSentimentCNN()
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func predict(image: UIImage) -> Double {
        
        var degree = 0.0
        
        do {
            if let resizedImage = resize(image: image, newSize: Prediction.trainedImageSize), let pixelBuffer = resizedImage.toCVPixelBuffer() {
                
                let prediction = try Prediction.model.prediction(data: pixelBuffer)
                print ("prediction value:", prediction.prob)
                degree = prediction.prob["Positive"] ?? 0.0
                degree = degree * 100
            }
        } catch {
            print("Error while doing prediction: \(error)")
            return 0.0
        }
        return degree
    }
}
