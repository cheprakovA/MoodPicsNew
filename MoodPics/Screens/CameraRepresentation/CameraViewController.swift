//
//  SecondViewController.swift
//  MoodPics
//
//  Created by Artemy Cheprakov on 13/08/2019.
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit
import AVKit

class CameraViewController: UIViewController {

    @IBOutlet weak var showPics: UIButton!
    @IBOutlet weak var currentMoodLevel: UILabel!
    
    var moodLevel = 0.0
    
    let cuptureSession = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    
}

