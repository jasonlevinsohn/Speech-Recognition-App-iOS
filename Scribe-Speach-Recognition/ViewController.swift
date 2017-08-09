//
//  ViewController.swift
//  Scribe-Speach-Recognition
//
//  Created by jlev on 8/9/17.
//  Copyright © 2017 L3. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var speechTextView: UITextView!
    
    // To play the audio file we need an audio player
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activitySpinner.isHidden = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }
    
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                // Get the audio file
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a") {
                    do {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        
                        sound.play()
                    } catch {
                        print("Error playing audio file")
                    }
                    
                    // Create the speech recognizer and a request
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request) { (result, error) in
                        if let error = error {
                            print("There was an error with speech recognition: \(error)")
                        } else {
                            self.speechTextView.text = result?.bestTranscription.formattedString
                        }
                    
                    }
                    
                }
            }
        }
    }
    
    @IBAction func playButtonPressed(_ sender: CircleButton) {
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeechAuth()
    }

}

