//
//  ViewController.swift
//  MySpeedometr
//
//  Created by kin on 09.07.16.
//  Copyright © 2016 kin. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation


class ViewController: UIViewController, CLLocationManagerDelegate, AVAudioPlayerDelegate {
    
    
    //MARK: Outlet
    @IBOutlet weak var speedLable: UILabel!
    @IBOutlet weak var limitLable: UILabel!
    @IBOutlet weak var imageLimit: UIImageView!
    @IBOutlet weak var sputnik: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    var locationManager = CLLocationManager()
    var player: AVAudioPlayer?
    var limitNumber = 300
    var isMirrored : Bool!
    let π = M_PI
    var soundOn = true
    var convertedSpeed:Double = 3.6
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        //locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeUpOrDown))
        swipeUp.numberOfTouchesRequired = 1
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        view.addGestureRecognizer(swipeUp)
        
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipeUpOrDown))
        swipeDown.numberOfTouchesRequired = 1
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        view.addGestureRecognizer(swipeDown)
        
        isMirrored = false
        
        
        segmentedControl.layer.cornerRadius = segmentedControl.bounds.height / 2
        segmentedControl.layer.borderColor = UIColor.blue.cgColor
        segmentedControl.layer.borderWidth = 1.5
        segmentedControl.layer.backgroundColor = UIColor.white.cgColor
        
       
        
        
        
        
    }
    
    // Location Speed
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let rawSpeed:Double = locations[0].speed * convertedSpeed  // mps to kph
        let accuracy: Double = locations[0].horizontalAccuracy
        
        if rawSpeed > 0  {
            
            speedLable.text = NSString(format:"%.f", rawSpeed) as String
            
        }
        
        if accuracy > 0 {
            sputnik.image = UIImage(named: "satellite_sending_signal-1")
            
        }else{
            sputnik.image = UIImage(named: "satellite_sending_signal")
            
        }
        
        // Repete Sound
        
        if Int(rawSpeed) > limitNumber && soundOn == true {
            
            playSound()
        }
        
    }
    
    // Play Sound Alarm
    
    func playSound() {
        let url = Bundle.main.url(forResource: "Submarine", withExtension: "aiff")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
            //player.numberOfLoops = 0
            //player.delegate = self
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    
    //MARK: Action
    
    
    
    @IBAction func muteSound(_ sender: UIButton) {
        
        soundOn = !soundOn
    }
    
    
    
    // LimitSpeed SegmentedControl
    
    @IBAction func limitSpeed(_ sender: UISegmentedControl) {
        
        
        switch sender.selectedSegmentIndex {
            
        case 0 : limitLable.text = "No limit"
        //speedLable.textColor = UIColor.cyanColor()
        limitNumber = 300
            
        case 1 : limitLable.text = "60"
        limitNumber = 30
        playSound()
            
        case 2 : limitLable.text = "80"
        limitNumber = 49
        playSound()
            
        case 3 : limitLable.text = "100"
        limitNumber = 50
        playSound()
            
        default : break
        }
        
    }
    // Swipe Mirror
    
    func swipeUpOrDown() {
        if (isMirrored!) {
            unmirrorScreen()
        } else {
            mirrorScreen()
        }
    }
    
    
    func mirrorScreen() {
        isMirrored = true
        UIView.beginAnimations(nil, context: nil)
        self.view.layer.transform = CATransform3DMakeRotation(CGFloat(π), -360.0, 1.0, 0.0)
        UIView.commitAnimations()
        sputnik.isHidden = true
        limitLable.isHidden = true
        imageLimit.isHidden = true
        segmentedControl.isHidden = true
        tabBarController?.tabBar.isHidden = true
        
        
        
    }
    
    func unmirrorScreen() {
        isMirrored = false
        UIView.beginAnimations(nil, context: nil)
        self.view.layer.transform = CATransform3DMakeRotation(CGFloat(π), 0.0, 0.0, 0.0)
        UIView.commitAnimations()
        sputnik.isHidden = false
        limitLable.isHidden = false
        imageLimit.isHidden = false
        segmentedControl.isHidden = false
        tabBarController?.tabBar.isHidden = false
        
    }
    
    
    
    
}

