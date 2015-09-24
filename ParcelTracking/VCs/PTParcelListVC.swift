//
//  ParcelListVC.swift
//  ParcelTracking
//
//  Created by Akio Yamadera on 9/19/15.
//  Copyright (c) 2015 com LLC. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class PTParcelListVC : PTBaseVC, UITableViewDelegate, UITableViewDataSource {
    
    //////////////////////// Properties of IBOutlets /////////////////
    
    @IBOutlet weak var mMapView: MKMapView!
    
    @IBOutlet weak var lblTrackNumber: UILabel!
    @IBOutlet weak var lblDeliveryDate: UILabel!
    
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblDeliveryType: UILabel!
    
    @IBOutlet weak var mTableView: UITableView!
    
    /////////////////////// Defined Properties //////////////////
    
    var _trackingNumber : String?
    var _organizedData : [PTTrackingNode] = [PTTrackingNode]()
    
    /////////////////////// Defined Funcs ///////////////////////
    
    func reloadData(){
        self.showActivityIndicator()
        self.lblTrackNumber.text = _trackingNumber
        PTAPIHandler.sharedInstance.trackParcels(/*"CD010945172RU"*/_trackingNumber!, callback: {(success, info, current) -> () in
            if success && (info != nil) && (current != nil){
                
                self.setData(info as! [PTTrackingNode]?)
                if let message = (current as! PTTrackingNode).message {
                       self.lblDeliveryDate.text = message
                }
                self.mTableView.reloadData()
            }else{
                self.showAlert("There isn't any information.", title: "ParcelTrack", buttonTitle: "OK")
            }
            self.hideActivityIndicator()
        });
        
    }
    
    func setData(data : [PTTrackingNode]?){
        _organizedData.removeAll(keepCapacity: false)
        for _data in data! {
            _organizedData.append(_data)
        }

    }
    
    /////////////////////// Override Funcs //////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    ///////////////////////// Funcs of IBActions ////////////////
    
    @IBAction func onBackBtnTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    ///////////////////////// TableView Delegate Implementation /////////////////////
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _organizedData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var resCell : UITableViewCell;
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ParcelListTVCell", forIndexPath: indexPath) as! PTParcelListTVCell
        
        let createTimeInterval : Int = (Int(_organizedData[indexPath.row].create_time!))!
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(createTimeInterval))
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd"
        let strDay = dateFormatter.stringFromDate(date)
        
        dateFormatter.dateFormat = "MMMM"
        let strMonth = dateFormatter.stringFromDate(date)
        
        dateFormatter.dateFormat = "hh:mm:ss"
        let strTime = dateFormatter.stringFromDate(date)
        
        cell.mDate.text = strDay + "\n" + strMonth
        cell.mTime.text = strTime
        cell.mInfo.text = _organizedData[indexPath.row].status
        cell.mInfoDescription.text = _organizedData[indexPath.row].message
        
        resCell = cell
        return resCell
    }
    
    ////////////////////// Util Funcs //////////////////////////
    
}