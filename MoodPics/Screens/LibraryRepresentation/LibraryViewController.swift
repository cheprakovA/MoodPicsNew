//
//  ThirdViewController.swift
//  MoodPics
//
//  Created by Artemy Cheprakov on 13/08/2019.
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit
import Vision

class LibraryViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var choosePhotoLabel: UILabel!
    
    var ptr = Prediction()
    
    var imagePicker = UIImagePickerController()
    var image: UIImage!
    
    var degree = 0.0
    
    @IBAction func onClickPickImage(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
        predictSelectedPhotoDegree()
        performSegue(withIdentifier: "LibrarySegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        configureLabel()
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
        let text = "CHOOSE A PICTURE FROM YOUR LIBRARY"
        choosePhotoLabel.font = font
        choosePhotoLabel.numberOfLines = 4
        choosePhotoLabel.text = text
        choosePhotoLabel.textColor = UIColor.white
    }
    
    func configure() {
        imagePicker.delegate = self
    }
    
    func predictSelectedPhotoDegree() {
        self.degree = self.ptr.predict(image: image)
    }
}

extension LibraryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
