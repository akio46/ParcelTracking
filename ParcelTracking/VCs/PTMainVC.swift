//
//  ViewController.swift
//  ParcelTracker
//
//  Created by Akio yamadera on 14/9/15.
//  Copyright (c) 2015  LLC. All rights reserved.
//

import UIKit

class PTMainVC : PTBaseVC {
    
    //////////////////////// Properties of IBOutlets /////////////////
    
    @IBOutlet weak var lblTrackNumber: UITextField!
    
    /////////////////////// Defined Properties //////////////////
    
    
    /////////////////////// Override Funcs //////////////////////

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if (segue.identifier == "MainVC2ParcelListVC") {
            (segue.destinationViewController as! PTParcelListVC)._trackingNumber = self.lblTrackNumber.text
        }
    }
    ///////////////////// Defined Funcs /////////////////////////
        
    
    ///////////////////////// Funcs of IBActions ////////////////

    @IBAction func onFindBtnTapped(sender: AnyObject) {
        
        if lblTrackNumber.text!.characters.count == 0 {
            showAlert("Tracking number should not be empty.", title: "ParcelTrack", buttonTitle: "OK")
            return
        }
        
        self.performSegueWithIdentifier("MainVC2ParcelListVC", sender: self)
    }
    
    
}

