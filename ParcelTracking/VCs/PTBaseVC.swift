//
//  PTBaseVC.swift
//  ParcelTracking
//
//  Created by Akio Yamadera on 9/19/15.
//  Copyright (c) 2015 com LLC. All rights reserved.
//

import Foundation
import UIKit

class PTBaseVC : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /////////////////// Activity Indicatior Implementation /////////////////////
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func showActivityIndicator() {
        let uiView = self.view
        
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = PTUtils.UIColorFromHex(0xffffff, alpha: 0.3)
        
        loadingView.frame = CGRectMake(0, 0, 80, 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = PTUtils.UIColorFromHex(0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        activityIndicator.center = CGPointMake(loadingView.frame.size.width / 2, loadingView.frame.size.height / 2);
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        activityIndicator.startAnimating()
    }

    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
    
    func showAlert(message: String, title : String = "ParcelTracking", buttonTitle: String = "OK") {
        
        var editedMessage = message
        
        
        if message.rangeOfString("Could not connect to the server", options: NSStringCompareOptions.CaseInsensitiveSearch, range: Range<String.Index>(start: message.startIndex, end: message.endIndex), locale: nil) != nil {
            editedMessage = "Please check your Internet connection."
        }
        
        let refreshAlert = UIAlertController(title: title, message: editedMessage, preferredStyle: UIAlertControllerStyle.Alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction) in
            
        }))
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
}