//
//  FoundTagsNotRegisteredViewController.swift
//  Third Eye
//
//  Created by Admin on 10/12/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import UIKit

class FoundTagsNotRegisteredViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblFoundTags: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblFoundTags.dataSource = self;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    let array = ["item1", "iten2", "item3"]
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 // This was put in mainly for my own unit testing
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count // Most of the time my data source is an array of something...  will replace with the actual name of the data source
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
              let cell = tableView.dequeueReusableCellWithIdentifier("FoundTagNotRegisteredViewCell") as! UITableViewCell
        
        
//        cell.configure(major: array[indexPath.item], minor: "Minor", minor1: 2)
        // cell.lblMajor?.text = array[indexPath.item]
        //  cell.textLabel?.text = array[indexPath.item]
        
        // cell.textLabel?.text = array[indexPath.item]
        
        return cell;

    }
 

}
