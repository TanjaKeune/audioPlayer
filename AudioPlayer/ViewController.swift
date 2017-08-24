//
//  ViewController.swift
//  AudioPlayer
//
//  Created by Tanja Keune on 8/23/17.
//  Copyright © 2017 SUGAPP. All rights reserved.
//

import UIKit
import AVFoundation

var player = AVAudioPlayer()


class ViewController: UIViewController {


    @IBOutlet weak var volumeOutlet: UISlider!
    @IBOutlet weak var scrubber: UISlider!
    
    var timer = Timer()
    let audioPath = Bundle.main.path(forResource: "Kinematic_-_Peyote", ofType: "mp3")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
        do {
            
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            scrubber.maximumValue = Float(player.duration)

            
        } catch {
            //          process any error
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func play(_ sender: Any) {
        
        player.play()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateScrubber), userInfo: nil, repeats: true)
    }

    func updateScrubber() {
        
        scrubber.value = Float(player.currentTime)
        
        
    }
    @IBAction func pause(_ sender: Any) {
        
        player.pause()
        timer.invalidate()
        
    }
    
    @IBAction func volumeControll(_ sender: Any) {
        
        player.volume = volumeOutlet.value
    }
    
    @IBAction func stop(_ sender: Any) {
        
        timer.invalidate()
        player.pause()
        
        do {
            
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            
            
        } catch {
            //          process any error
        }
    }
    
    @IBAction func scrubberAction(_ sender: Any) {
        
        player.currentTime = TimeInterval(scrubber.value)
    }
    
    
}

