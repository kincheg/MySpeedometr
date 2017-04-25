//
//  STViewController.swift
//  MySpeedometr
//
//  Created by kin on 14.07.16.
//  Copyright © 2016 kin. All rights reserved.
//

import UIKit
import AVFoundation

class STViewController: UIViewController {
    
    
    var soundOn = true
    var convertedSpeed:Double = 0
    var line = true
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    
    
    //MARK: Action
    
    
    
    
    @IBAction func mapTracking(_ sender: UISwitch) {
        
        line = !line
        mapTracking()
        
       
        
    }
    
    
    
    
    @IBAction func convertedSpeed(_ sender: UISegmentedControl)  {
        
        switch sender.selectedSegmentIndex {
            
        case 0 : convertedSpeed = 3.6
            
        case 1 : convertedSpeed = 2.23694
            
        default: break
            
            
        }
        speedConverted()
    }
    
    
    @IBAction func muteSound(_ sender: UISwitch) {
        
        soundOn = !soundOn
        muteSound()
        
        
    }
    
    // Sound Off
    
    func muteSound() {
        
        if let controller = tabBarController!.viewControllers![0] as? ViewController {
            controller.soundOn = self.soundOn
        }
    }
    
    // Speed mp/h km/h
    
    func speedConverted() {
        
        if let controller = tabBarController!.viewControllers![0] as? ViewController {
            controller.convertedSpeed = self.convertedSpeed
        }
    }
    
    func mapTracking() {
        
        if let controller = tabBarController!.viewControllers![1] as? MapViewController {
            controller.line = self.line
        }
    }

    
}
