//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Matt Benavides on 7/28/18.
//  Copyright © 2018 Big Baller Brand. All rights reserved.
//

import UIKit
import AVFoundation

// tell Xcode the class conforms to AVAudioRecorderDelegate protocol,
// this means that we implement a function described in that delegate protocol, and
// our view controller can act as the delegate for the AVAudioRecorder
class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    // a class in swift can only inherit from ONE super class, but it can conform to as many as you want
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    // Called when your view is first loaded into memory,
    // Called before view even appears on screen
    // override makes this implementation get called, instead of default
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopRecordingButton.isEnabled = false
    }
    
    // Called when your view is just about to appear on the screen,
    // called after viewDidLoad()
    // override makes this implementation get called, instead of default
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print ("viewWIllAppear() called")
    }

    @IBAction func recordAudio(_ sender: Any) {
        print ("record wbutton was pressed!")
        recordingLabel.text = "Recording in Progress"
        stopRecordingButton.isEnabled = true // enable stop button
        recordButton.isEnabled = false // disable record button
        
        // get the applications current path
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        // construct the full file path name of audio recording
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print (filePath)
        // create an audio session
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        // create an audio recorder with the constructed file path
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        // set this view controller as the delegate of the AVAudioRecorder
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        print ("stop recording button was pressed ")
        
        recordButton.isEnabled = true // enable record button
        stopRecordingButton.isEnabled = false // disable stop button
        recordingLabel.text = "Tap To Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        // set audio session to inactive
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print ("finished recording")
        if flag {
            // perform programmatic segue and send with it the path to the recorded sound
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print ("recording was not successful")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioUrl = sender as! URL
            playSoundsVC.recordedAudioUrl = recordedAudioUrl
        }
    }
}

