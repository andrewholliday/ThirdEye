//
//  FoundTagsViewController.swift
//  Third Eye
//
//  Created by Admin on 10/11/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//
import UIKit


class FoundTagsViewController:  UITableViewController {

    
    let array = ["item1", "iten2", "item3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //var cell = FoundTagViewCell()
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FoundTagViewCell") as! FoundTagViewCell
        
        
        cell.configure(major: array[indexPath.item], minor: "Minor", minor1: 2)
       // cell.lblMajor?.text = array[indexPath.item]
      //  cell.textLabel?.text = array[indexPath.item]
        
       // cell.textLabel?.text = array[indexPath.item]
        
        return cell;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    
    
    
}
