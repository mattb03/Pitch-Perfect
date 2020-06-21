//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Matt Benavides on 8/4/18.
//  Copyright © 2018 Big Baller Brand. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioUrl: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    enum ButtonType: Int { case slow = 0, fast, chipmunk, vader, echo, reverb }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        print ("play sound button pressed")
        switch (ButtonType(rawValue: sender.tag)) {
        case .slow?:
            playSound(rate: 0.5)
        case .fast?:
            playSound(rate: 1.5)
        case .chipmunk?:
            playSound(pitch: 1000)
        case .vader?:
            playSound(pitch: -1000)
        case .echo?:
            playSound(echo: true)
        case .reverb?:
            playSound(reverb: true)
        case .none:
            break
        }
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        print ("stop audio button pressed")
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /*
            Need to center content and scale aspect fit
            image to prevent images from stretching
            on smaller iPhone landscape modes
        */
        slowButton.contentMode = .center
        slowButton.imageView?.contentMode = .scaleAspectFit
        fastButton.contentMode = .center
        fastButton.imageView?.contentMode = .scaleAspectFit
        highPitchButton.contentMode = .center
        highPitchButton.imageView?.contentMode = .scaleAspectFit
        lowPitchButton.contentMode = .center
        lowPitchButton.imageView?.contentMode = .scaleAspectFit
        echoButton.contentMode = .center
        echoButton.imageView?.contentMode = .scaleAspectFit
        reverbButton.contentMode = .center
        reverbButton.imageView?.contentMode = .scaleAspectFit
        stopButton.contentMode = .center
        stopButton.imageView?.contentMode = .scaleAspectFit
        setupAudio()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
