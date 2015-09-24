//
//  PTAPIHandler.swift
//  ParcelTracker
//
//  Created by Akio yamadera on 14/9/15.
//  Copyright (c) 2015  LLC. All rights reserved.
//

// All of server/client communication functions are defined in this class
// Alamofire which is swift port of AFNetworking which is proven and widely used in Objective C
// is used

import Foundation

class PTAPIHandler {
    static let sharedInstance = PTAPIHandler()
    
    let PTAPIURL:String = "http://logistics.qwintry.com/api/"; //TODO: Need to be changed.
    
    func getCommentRequest(mode: Method, suburl: String, params: [String: AnyObject]? = nil) -> Request {
        let URL = NSURL(string: PTAPIURL)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(suburl))
        
        
        mutableURLRequest.HTTPMethod = mode.rawValue
        mutableURLRequest.setValue("Bearer " + PTCacheHandler.sharedInstance.getAPI_KEY(), forHTTPHeaderField: "Authorization")
        return request(ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0)
    }
    
    /************ Response ******************
    {
        "success" : true,
        "current" : {
            "status" : "info_received",
            "message" : "Electronic info received",
            "status_ru" : "информация получена",
            "create_time" : "1442324302",
            "message_ru" : "Данные о посылке получены"
        },
        "history" : [
            {
                "status" : "info_received",
                "message" : "Electronic info received",
                "status_ru" : "информация получена",
                "create_time" : "1442324302",
                "message_ru" : "Данные о посылке получены"
            }
        ]
    }

    ****************************************/

    func trackParcels(trackNumber: String, callback: ((Bool, AnyObject?, AnyObject?) -> ())) -> Request {
        return getCommentRequest(Method.GET, suburl: "track", params: ["tracking" : trackNumber])
            .responseJSON{ (request, response, result) in
                if(result.error != nil) {
                    callback(false, nil, nil);
                }
                else {
                    switch(result){
                    case .Success(let info):
                        var sJSONObj = JSON(info);
                        let trackingNodes = Mapper<PTTrackingNode>().mapArray(sJSONObj["history"].rawString()!)
                        let current = Mapper<PTTrackingNode>().map(sJSONObj["current"].rawString()!)
                        print(sJSONObj.rawString()!)
                        callback(true, trackingNodes, current)
                        break
                    case .Failure(_, let erroor):
                        callback(false, nil, nil)
                        break
                    }
                    
                }
        }
    }
}