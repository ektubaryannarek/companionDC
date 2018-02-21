//
//  VoiceRecordingScreenViewController.swift
//  Companion
//
//  Created by Narek Ektubaryan on 2/21/18.
//  Copyright © 2018 Double Coconut. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class VoiceRecordingScreenViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var stopButton: UIView!
    @IBOutlet weak var recordButton: UIView!
    @IBOutlet weak var doneButton: UIView!
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        let recordGesture = UITapGestureRecognizer(target: self, action: #selector(self.recordButtonClicked))
                        self.recordButton.addGestureRecognizer(recordGesture)
                        self.recordButton.isHidden = false
                    } else {
                        // failed to record!
                    }
                }
            }
        } catch {
            // failed to record!
        }
        
        stopButton.isHidden = true
        doneButton.isHidden = true
        
        let stopGesture = UITapGestureRecognizer(target: self, action: #selector(stopButtonClicked))
        let doneGesture = UITapGestureRecognizer(target: self, action: #selector(doneButtonClicked))
        stopButton.addGestureRecognizer(stopGesture)
        doneButton.addGestureRecognizer(doneGesture)
    }

    @objc func stopButtonClicked(){
        recordButton.isHidden = true
        doneButton.isHidden = false
        stopButton.isHidden = true
        
        finishRecording(success: true)
    }
    
    @objc func doneButtonClicked(){
        
    }
    
    @objc func recordButtonClicked(){
        recordButton.isHidden = true
        startRecording()
    }
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            stopButton.isHidden = false
        } catch {
            finishRecording(success: false)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            doneButton.isHidden = false
        } else {
            recordButton.isHidden = false
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}
