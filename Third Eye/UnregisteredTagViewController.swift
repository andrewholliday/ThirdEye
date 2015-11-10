//
//  UnregisteredTagViewController.swift
//  Third Eye
//
//  Created by Admin on 11/8/15.
//  Copyright © 2015 Admin. All rights reserved.
//

import UIKit

class UnregisteredTagViewController: UIViewController, ITagObserver {
    
    
    @IBOutlet weak var tblUnregistered: UITableView!
    @IBOutlet var lblTagsFoundMessage: UILabel!
    
     var SelectedTagIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        TagManager.Service.RemoveAllUnregisteredTags()
        TagManager.Service.RegisterObserver(self)
        TagMonitor.Service.StartMonitor()
    }
    
    func UpdateView()
    {
        tblUnregistered.reloadData()
        
        if (TagManager.Service.unregisteredTags.count > 0)
        {
            lblTagsFoundMessage.text = "Unregistered Tags Found"
        }
        else
        {
             lblTagsFoundMessage.text = "No Unregistered Tags Found"
        }
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
        return TagManager.Service.unregisteredTags.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //        var cell:UnregisteredTagViewCell = tableView.dequeueReusableCellWithIdentifier("UnregisteredTagViewCell") as! UnregisteredTagViewCell
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("UnregisteredTagTableCell")! as UITableViewCell
        
        
                if (indexPath.section == 0)
                {
                    cell.textLabel?.text = " Tag: " + String(TagManager.Service.unregisteredTags[indexPath.row].major) + " " + String(TagManager.Service.unregisteredTags[indexPath.row].minor)
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
    
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        if (indexPath.section == 0) {
            self.SelectedTagIndex = indexPath.row
            //         self.performSegueWithIdentifier("UnregisteredTag", sender: self)
        }
        
        //
        //        let row = indexPath.row
        //    println(array[indexPath.row])
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!)
        
    {
        
        if segue.identifier == "UnregisteredTag"
            
        {
            let detailsViewController = segue.destinationViewController as? RegisterViewController
            detailsViewController!.SelectedTag  =  TagManager.Service.unregisteredTags[self.SelectedTagIndex]
            
        }
        
        
        
        
    }


}
