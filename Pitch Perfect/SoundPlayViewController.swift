//
//  SoundPlayViewController.swift
//  Pitch Perfect
//
//  Created by Tejas Patel on 1/19/15.
//  Copyright (c) 2015 TP. All rights reserved.
//

import UIKit
import AVFoundation


class SoundPlayViewController: UIViewController {
    var audioPlayer:AVAudioPlayer!
    var receivedData:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine=AVAudioEngine()
        //if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
            //var filePathUrl = NSURL.fileURLWithPath(filePath);
            audioPlayer = AVAudioPlayer(contentsOfURL: receivedData.filePathUrl, error: nil)
            audioPlayer.enableRate=true;
        //}
        // Do any additional setup after loading the view.
        audioFile = AVAudioFile(forReading: receivedData.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slowSound(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.play()
        audioPlayer.currentTime=0.0
        audioPlayer.rate=0.6
    }

    @IBAction func fastSound(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.play()
        audioPlayer.currentTime=0.0
        audioPlayer.rate=1.6
    }
    @IBAction func playStop(sender: UIButton) {
        audioPlayer.stop()
    
    }
    @IBOutlet weak var playChimp: UIButton!
    
    @IBAction func playChimpmunk(sender: AnyObject) {
        playWithVarPitch(1000)
    }
    @IBAction func playDarth(sender: UIButton) {
        playWithVarPitch(-1000)
    }
    func playWithVarPitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode=AVAudioPlayerNode();
        audioEngine.attachNode(audioPlayerNode)
        var changePitch = AVAudioUnitTimePitch()
        changePitch.pitch=pitch
        audioEngine.attachNode(changePitch)
        audioEngine.connect(audioPlayerNode, to: changePitch, format: nil)
        audioEngine.connect(changePitch, to: audioEngine.outputNode, format : nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
