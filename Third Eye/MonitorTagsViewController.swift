//
//  MonitorTagsViewController.swift
//  Third Eye
//
//  Created by Admin on 10/16/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import UIKit

class MonitorTagsViewController: UIViewController, ITagObserver {

    
    @IBOutlet weak var tblTags: UITableView!
    
    var SelectedTagIndex = Int()
    

    override func viewDidLoad() {
        super.viewDidLoad()

         TagManager.Service.RemoveAllUnregisteredTags()
         TagManager.Service.RegisterObserver(self)
        
         TagMonitor.Service.StartMonitor()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func UpdateView()
    {
        tblTags.reloadData()
    }
    
     func tableView(tableView: UITableView, titleForHeaderInSection section: Int)
        -> String {
            if (section == 0)
            {
                return "Unregistered Tags"
            }
            else if (section == 1)
            {
                return "Registered Tags"
            }
            
            return "";
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
       if (section == 0)
       {
            return TagManager.Service.unregisteredTags.count
        }
        else if (section == 1)
       {
            return TagManager.Service.registedTags.count
        }
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //        var cell:UnregisteredTagViewCell = tableView.dequeueReusableCellWithIdentifier("UnregisteredTagViewCell") as! UnregisteredTagViewCell
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TagTableCell")! as UITableViewCell
        
        
        if (indexPath.section == 0)
        {
                  cell.textLabel?.text = " Tag: " + String(TagManager.Service.unregisteredTags[indexPath.row].minor) + " " + String(TagManager.Service.unregisteredTags[indexPath.row].minor)
        }
        else if (indexPath.section == 1)
        {
            let key = Array(TagManager.Service.registedTags.keys)[indexPath.row]
            let item = TagManager.Service.registedTags[key] as RegisteredTag?
            
           cell.textLabel?.text = " Tag: " + item!.name! + " Distance: " + String(item!.distance)
                
            
        }
        
        
       // let beacon:CLBeacon = beacons![indexPath.row]
        
       // cell.configure(String(stringInterpolationSegment: beacon.minor))
        
  
        
        // cell.textLabel?.text = self.array[indexPath.row]
        
        //   cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.blueColor() :
        //  UIColor.redColor()
        
        return cell
    }
    
//     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    
   
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete && indexPath.section==1) {
            var regTag = TagManager.Service.GetTagByIndex(indexPath.row)
            TagManager.Service.DeleteTag(regTag)
            tblTags.reloadData()
        }
        
    }
    
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        if (indexPath.section==0) {
            self.SelectedTagIndex = indexPath.row
   //         self.performSegueWithIdentifier("UnregisteredTag", sender: self)
        }
        
        //
        //        let row = indexPath.row
    //    println(array[indexPath.row])
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

*/
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!)
        
    {
        
        if segue.identifier == "UnregisteredTag"
            
        {
            let detailsViewController = segue.destinationViewController as? RegisterViewController
           detailsViewController!.SelectedTag  =  TagManager.Service.unregisteredTags[self.SelectedTagIndex]
            
        }
        
       
        
        
    }
//        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//            // Get the new view controller using segue.destinationViewController.
//            // Pass the selected object to the new view controller.
//        }


}
