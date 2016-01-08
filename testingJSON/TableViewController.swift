//
//  TableViewController.swift
//  
//
//  Created by Anil on 11/05/15.
//
//

import UIKit

class TableViewController: UITableViewController {

    var tableName = [String]()
    var tableID = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getContactListJSON()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getContactListJSON(){
        let urlString = "http://jsonplaceholder.typicode.com/users"
        let urlEncodedString = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let url = NSURL( string: urlEncodedString!)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, innerError) in
            let json = JSON(data: data!)
            let contactsArray = json.arrayValue
            
            dispatch_async(dispatch_get_main_queue(), {
                for contacts in contactsArray
                {
                    let id = contacts["id"].stringValue
                    let name = contacts["name"].stringValue
                    print( "id: \(id) name: \(name)" )
                    self.tableName.append(name)
                    self.tableID.append(id)
                }
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView.reloadData()
                })
            })
        }
        task.resume()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableName.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell

        // Configure the cell...
        cell.id.text = tableID[indexPath.row]
        cell.name.text = tableName[indexPath.row]
        return cell
        
    }
}
