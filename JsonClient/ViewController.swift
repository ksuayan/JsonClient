//
//  ViewController.swift
//  JsonClient
//
//  Created by Suayan, William on 7/18/14.
//  Copyright (c) 2014 Kyo Suayan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIControllerProtocol {
                            
    @IBOutlet var appTableView: UITableView
    
    var searchResultsData: NSArray = []
    var api: APIController = APIController()
    
    func JSONAPIResults(results: NSArray) {
        dispatch_async(dispatch_get_main_queue(), {
            self.searchResultsData = results
            self.appTableView.reloadData()
        })
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return searchResultsData.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cellIdentifier: String = "MyResultsCell"
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell

        //Create a variable that will contain the result data array item for each row
        var cellData: NSDictionary = self.searchResultsData[indexPath.row] as NSDictionary
        
        //Assign and display the Title field
        cell.textLabel.text = cellData["Name"] as String
        cell.detailTextLabel.text = cellData["Artist"] as String
        
        return cell
    }
    
    override func viewDidLoad() {
        //Construct the API URL that you want to call
        var term: String = "summer"
        var APIBaseUrl: String = "http://node.suayan.com/search/"
        var urlString:String = "\(APIBaseUrl)"+"\(term)"
        
        //Call the API by using the delegate and passing the API url
        self.api.delegate = self
        api.GetAPIResultsAsync(urlString)
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

