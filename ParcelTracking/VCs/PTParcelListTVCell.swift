//
//  PTParcelListTVCell
//  ParcelTracking
//
//  Created by Akio Yamadera on 9/19/15.
//  Copyright (c) 2015 com LLC. All rights reserved.
//

import UIKit

class PTParcelListTVCell: UITableViewCell {
    
    
    @IBOutlet weak var mDate: UILabel!
    
    @IBOutlet weak var mTime: UILabel!
    @IBOutlet weak var mInfo: UILabel!
    @IBOutlet weak var mInfoDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
