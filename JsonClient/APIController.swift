//
//  APIController.swift
//  JsonClient
//
//  Created by Suayan, William on 7/18/14.
//  Copyright (c) 2014 Kyo Suayan. All rights reserved.
//

import UIKit


protocol APIControllerProtocol {
    func JSONAPIResults(results: NSArray)
}

class APIController: NSObject {
    
    var delegate:APIControllerProtocol?
    
    func GetAPIResultsAsync(urlString:String) {
        
        //The Url that will be called
        var url = NSURL.URLWithString(urlString)
        
        //Create a request
        var request: NSURLRequest = NSURLRequest(URL: url)
        
        //Create a queue to hold the call
        var queue: NSOperationQueue = NSOperationQueue()
        
        // Sending Asynchronous request using NSURLConnection
        NSURLConnection.sendAsynchronousRequest(request, queue: queue,
            completionHandler:{(response:NSURLResponse!, responseData:NSData!, error: NSError!) ->Void in
            var error: AutoreleasingUnsafePointer<NSError?> = nil
                
            // Serialize the JSON result into a dictionary
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(responseData, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
            
            // If there is a result add the data into an array
            if jsonResult.count>0 && jsonResult["result"].count > 0 {
                
                var results: NSArray = jsonResult["result"] as NSArray
                //Use the completion handler to pass the results
                self.delegate?.JSONAPIResults(results)
                
            } else {
                println(error)
            }
       })
    }
}
