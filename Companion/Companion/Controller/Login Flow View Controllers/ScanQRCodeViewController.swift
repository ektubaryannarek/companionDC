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
    
    let supportedCodeTypes = [AVMetadataObject.ObjectType.qr,
                              AVMetadataObject.ObjectType.code39,
                              AVMetadataObject.ObjectType.code93,
                              AVMetadataObject.ObjectType.code128,
                              AVMetadataObject.ObjectType.ean8,
                              AVMetadataObject.ObjectType.ean13,
                              AVMetadataObject.ObjectType.face,
                              AVMetadataObject.ObjectType.pdf417,
                              AVMetadataObject.ObjectType.itf14,
                              AVMetadataObject.ObjectType.dataMatrix,
                              AVMetadataObject.ObjectType.interleaved2of5]
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !(session?.isRunning)! {
            session?.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (session?.isRunning)! {
            session?.stopRunning()
        }
    }
    
    func makeNavBarTransparent(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    @objc func nextButtonClicked(){
        performSegue(withIdentifier: "toConnectWithMyiaFromScan", sender: nil)
    }
    
    @objc func troubleButtonClicked(){
        performSegue(withIdentifier: "toEnterCode", sender: nil)
    }
    
    func createSession() {
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video),
            let _ = try? AVCaptureDeviceInput(device: captureDevice) else {
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
            
//            if let qrCodeFrameView = qrCodeFrameView {
//                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
//                qrCodeFrameView.layer.borderWidth = 2
//                view.addSubview(qrCodeFrameView)
//                view.bringSubview(toFront: qrCodeFrameView)
//            }
            // Set the input device on the capture session.
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
        
        prevLayer = AVCaptureVideoPreviewLayer(session: session!)
        prevLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        prevLayer?.frame.size = myView.frame.size
        myView.layer.addSublayer(prevLayer!)
        
        session?.startRunning()
    }
    
    // AVCaptureMetadataOutputObjectsDelegate protocol
    
    func metadataOutput( _ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            messageLabel.text = "No QR code is detected"
            return
        }

        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
//            let barCodeObject = self.prevLayer?.transformedMetadataObject(for: metadataObj)
//            self.qrCodeFrameView?.frame = barCodeObject!.bounds

            if metadataObj.stringValue != nil {
                self.messageLabel.text = metadataObj.stringValue
                session?.stopRunning()
            }
        }
    }
}



