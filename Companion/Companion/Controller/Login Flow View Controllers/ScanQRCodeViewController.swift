//
//  ScanQRCodeViewController.swift
//  Companion
//
//  Created by Narek Ektubaryan on 2/14/18.
//  Copyright © 2018 Double Coconut. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class ScanQRCodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var nextButtonView: UIView!
    @IBOutlet weak var troubleMessageView: UIView!

    @IBOutlet weak var myView: UIView!
    
    var session: AVCaptureSession?
    var device: AVCaptureDevice?
    var input: AVCaptureDeviceInput?
    var output: AVCaptureMetadataOutput?
    var prevLayer: AVCaptureVideoPreviewLayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavBarTransparent()
        
        // adding gestures
        let nextButtonGesture = UITapGestureRecognizer(target: self, action: #selector(nextButtonClicked))
        let troubleMessageGesture = UITapGestureRecognizer(target: self, action: #selector(troubleButtonClicked))
        self.nextButtonView.addGestureRecognizer(nextButtonGesture)
        self.troubleMessageView.addGestureRecognizer(troubleMessageGesture)
        createSession ()
    }
    
    func makeNavBarTransparent(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func nextButtonClicked(){
        performSegue(withIdentifier: "toConnectWithMyiaFromScan", sender: nil)
    }
    
    func troubleButtonClicked(){
        performSegue(withIdentifier: "toEnterCode", sender: nil)
    }
    
    func createSession() {
        session = AVCaptureSession()
        device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        guard let captureDevice = device else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session?.addInput(input)
        } catch {
            print(error)
            return
        }
        
        prevLayer = AVCaptureVideoPreviewLayer(session: session)
        prevLayer?.frame.size = myView.frame.size
        prevLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        myView.layer.addSublayer(prevLayer!)
        session?.startRunning()
    }
    
    func cameraWithPosition(_ position: AVCaptureDevicePosition) -> AVCaptureDevice? {
        if let deviceDescoverySession = AVCaptureDeviceDiscoverySession.init(deviceTypes: [AVCaptureDeviceType.builtInWideAngleCamera],
                                                                             mediaType: AVMediaTypeVideo,
                                                                             position: AVCaptureDevicePosition.unspecified) {
            
            for device in deviceDescoverySession.devices {
                if device.position == position {
                    return device
                }
            }
        }
        return nil
    }

}
