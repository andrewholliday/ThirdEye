//
//  UnregisteredTagViewController.swift
//  Third Eye
//
//  Created by Admin on 11/8/15.
//  Copyright © 2015 Admin. All rights reserved.
//

import UIKit

class UnregisteredTagViewController: UIViewController {
    
    
    @IBOutlet var lblUnregisteredTags: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /******table view *****/
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return TagManager.Service.registedTags.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //        var cell:UnregisteredTagViewCell = tableView.dequeueReusableCellWithIdentifier("UnregisteredTagViewCell") as! UnregisteredTagViewCell
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("UnregisteredTagTableCell")! as UITableViewCell
        
        
                if (indexPath.section == 0)
                {
                    cell.textLabel?.text = " Tag: " + String(TagManager.Service.unregisteredTags[indexPath.row].minor) + " " + String(TagManager.Service.unregisteredTags[indexPath.row].minor)
                }
        //        else if (indexPath.section == 1)
        //        {
//        let key = Array(TagManager.Service.registedTags.keys)[indexPath.row]
//        let item = TagManager.Service.registedTags[key] as RegisteredTag?
//        
//        cell.textLabel?.text = " Tag: " + item!.name! + " Distance: " + String(item!.distance)
        
        
        // }
        
        
        return cell
    }


}
