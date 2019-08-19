//
//  SecondViewController.swift
//  MoodPics
//
//  Created by Artemy Cheprakov on 13/08/2019.
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit
import Vision
import AVFoundation

class CameraViewController: UIViewController {
    
    @IBOutlet weak var moodLevel: UILabel!
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var takePhotoButton: UIButton!
    
    @IBAction func didTakePhoto(_ sender: Any) {
        performSegue(withIdentifier: "CameraSegue", sender: self)
    }
    
    var degree = 0.0
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCaptureVideoDataOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video) else {
            print("Unable to access back camera!")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            stillImageOutput = AVCaptureVideoDataOutput()
            
            stillImageOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
            
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        } catch let error {
            print("Error Unable to init BACK camera: \(error.localizedDescription)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PhotoViewController
        destinationVC.degree = self.degree
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        configureLabel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }

    func setupLivePreview() {
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        videoPreviewLayer.frame = self.view.frame
        self.view.layer.insertSublayer(videoPreviewLayer, at: 0)
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }
    
    func configureButton() {
        takePhotoButton.setImage(UIImage(named: "photo-camera"), for: .normal)
    }
    
    func configureLabel() {
        let font = UIFont(name: "Comfortaa-SemiBold", size: ceil(moodLevel.bounds.width / 15))
        moodLevel.font = font
        moodLevel.textColor = UIColor.white
        moodLevel.text = nil
    }

}

extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        guard let model = try? VNCoreMLModel(for: VisualSentimentCNN().model) else {
            return
        }
        let request = VNCoreMLRequest(model: model) { (finishedRequest, err) in
            
            guard let results = finishedRequest.results as? [VNClassificationObservation] else {
                return
            }
            guard let firstObserve = results.first else {
                return
            }
            
            if (String(firstObserve.identifier) == "Positive") {
                self.degree = Double(firstObserve.confidence * 100)
            } else {
                self.degree = 100 - Double(firstObserve.confidence * 100)
            }
            
            DispatchQueue.main.async {
                self.moodLevel.text = "SENTIMENT IS \(Int(self.degree))%"
            }
        }
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
}

