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
    @IBOutlet weak var messageLabel: UILabel!
    
    var qrCodeFrameView: UIView?
    var session: AVCaptureSession?
    var device: AVCaptureDevice?
    var input: AVCaptureDeviceInput?
    var output: AVCaptureMetadataOutput?
    var prevLayer: AVCaptureVideoPreviewLayer?
    
    let supportedCodeTypes = [AVMetadataObjectTypeQRCode,
                                      AVMetadataObjectTypeCode39Code,
                                      AVMetadataObjectTypeCode93Code,
                                      AVMetadataObjectTypeCode128Code,
                                      AVMetadataObjectTypeEAN8Code,
                                      AVMetadataObjectTypeEAN13Code,
                                      AVMetadataObjectTypeFace,
                                      AVMetadataObjectTypePDF417Code,
                                      AVMetadataObjectTypeITF14Code,
                                      AVMetadataObjectTypeDataMatrixCode,
                                      AVMetadataObjectTypeInterleaved2of5Code,
                                      AVMetadataObjectTypeQRCode]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavBarTransparent()
        
        // adding gestures
        let nextButtonGesture = UITapGestureRecognizer(target: self, action: #selector(nextButtonClicked))
        let troubleMessageGesture = UITapGestureRecognizer(target: self, action: #selector(troubleButtonClicked))
        self.nextButtonView.addGestureRecognizer(nextButtonGesture)
        self.troubleMessageView.addGestureRecognizer(troubleMessageGesture)
        
        // create capture session
        createSession()
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
        device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        guard let captureDevice = device else {
            print("Failed to get the camera device")
            return
        }
        do {
            session = AVCaptureSession()
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session?.addInput(input)
            let output = AVCaptureMetadataOutput()
            session?.addOutput(output)
            output.setMetadataObjectsDelegate(self, queue: .main)
            output.metadataObjectTypes = supportedCodeTypes
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                myView.addSubview(qrCodeFrameView)
                myView.bringSubview(toFront: qrCodeFrameView)
            }
        } catch {
            print(error)
            return
        }
        
        prevLayer = AVCaptureVideoPreviewLayer(session: session)
        prevLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        prevLayer?.frame.size = myView.frame.size
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
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!){
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            messageLabel.text = "No QR code is detected"
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = self.prevLayer?.transformedMetadataObject(for: metadataObj)
            self.qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                self.messageLabel.text = metadataObj.stringValue
            }
        }
    }

    // SWIFT 4.
//    func metadataOutput( output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
//
//        if metadataObjects.count == 0 {
//            qrCodeFrameView?.frame = CGRect.zero
//            messageLabel.text = "No QR code is detected"
//            return
//        }
//
//        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
//
//        if metadataObj.type == AVMetadataObjectTypeQRCode {
//            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
//            let barCodeObject = self.prevLayer?.transformedMetadataObject(for: metadataObj)
//            self.qrCodeFrameView?.frame = barCodeObject!.bounds
//
//            if metadataObj.stringValue != nil {
//                self.messageLabel.text = metadataObj.stringValue
//            }
//        }
//    }
}


