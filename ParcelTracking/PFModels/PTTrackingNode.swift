//
//  PTTrackingNode.swift
//  ParcelTracking
//
//  Created by Akio Yamadera on 9/19/15.
//  Copyright (c) 2015 com LLC. All rights reserved.
//

import Foundation

/*
{
    "status" : "info_received",
    "message" : "Electronic info received",
    "status_ru" : "информация получена",
    "create_time" : "1442324302",
    "message_ru" : "Данные о посылке получены"
}
*/

class PTTrackingNode: PTModelBase, Mappable {
    var status: String?
    var message: String?
    var status_ru: String?
    var create_time: String?
    var message_ru: String?
    
    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        status_ru <- map["status_ru"]
        create_time <- map["create_time"]
        message_ru <- map["message_ru"]
    }
    
    override func parse(json: JSON) -> PTTrackingNode {
        let info = Mapper<PTTrackingNode>().map(json.rawString()!)
        return info!
    }
    
    override func serialize() -> String? {
        return Mapper().toJSONString(self, prettyPrint: true)
    }
    
}