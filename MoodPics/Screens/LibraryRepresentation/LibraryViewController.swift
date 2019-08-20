//
//  ThirdViewController.swift
//  MoodPics
//
//  Created by Artemy Cheprakov on 13/08/2019.
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit
import Vision

class LibraryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var previewImage: UIImageView!
    
    let predictionService = PredictionService()
    let imagePickerController = UIImagePickerController()
    
    var degree = 0.0
    
    @IBAction func onClickPickImage(_ sender: Any) {
        present(imagePickerController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PhotoViewController
        destinationVC.degree = self.degree
    }
    
    func configureButton() {
        button.setBackgroundImage(UIImage(named: "upload111"), for: .normal)
    }
    
    func configureLabel() {
        let font = UIFont(name: "Comfortaa-Regular", size: 50)
        let text = "CHOOSE A PICTURE FROM LIBRARY"
        
        informationLabel.font = font
        informationLabel.numberOfLines = 4
        informationLabel.text = text
        informationLabel.textColor = UIColor.white
    }
    
    func configure() {
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        
        configureButton()
        configureLabel()
        configureGesture()
    }
    
    func reconfigure() {
        let font = UIFont(name: "Comfortaa-Light", size: 40)
        let text = "SENTIMENT LEVEL IS \(Int(degree)) SWIPE LEFT TO PERFORM PICS"
        
        informationLabel.font = font
        informationLabel.text = text

    }
    
    func configureGesture() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                do {
                    performSegue(withIdentifier: "LibrarySegue", sender: self)
                }
            default:
                break
            }
        }
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            previewImage!.contentMode = .scaleAspectFill
            previewImage!.image = pickedImage
        }
        
        self.degree = self.predictionService.predict(image: previewImage!.image!)
        
        reconfigure()

        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
