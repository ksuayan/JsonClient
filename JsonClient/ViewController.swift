//
//  ViewController.swift
//  JsonClient
//
//  Created by Suayan, William on 7/18/14.
//  Copyright (c) 2014 Kyo Suayan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,
APIControllerProtocol {
    @IBOutlet var searchTerm: UISearchBar
    @IBOutlet var appTableView: UITableView
    
    var searchResultsData: NSArray = []
    var api: APIController = APIController()
    
    func JSONAPIResults(results: NSArray) {
        dispatch_async(dispatch_get_main_queue(), {
            self.searchResultsData = results
            self.appTableView.reloadData()
        })
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar!) {
        println("textDidEndEditing")
        getRequest(searchBar.text)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar!) {
        println("button clicked...")
        getRequest(searchBar.text)
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
        cell.textLabel.text = cellData["Name"] as String?
        cell.detailTextLabel.text = cellData["Artist"] as String?
        
        return cell
    }
    
    func getRequest(term: String) {
        var APIBaseUrl: String = "http://node.suayan.com/search/"
        var urlString:String = "\(APIBaseUrl)"+"\(term)"
        if !term.isEmpty {
            api.GetAPIResultsAsync(urlString);
        }

    }
    
    override func viewDidLoad() {
        //Call the API by using the delegate and passing the API url
        self.api.delegate = self
        getRequest("summer");
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

