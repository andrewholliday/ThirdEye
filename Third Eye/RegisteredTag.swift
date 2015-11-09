//
//  RegisteredChild.swift
//  Third Eye
//
//  Created by Admin on 10/8/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import Foundation
import CoreLocation

class RegisteredTag: Tag  {
    
    var name: String?
    var distance: Int = 0
    var alarmDistance: Int?
    
    var isMonitoring: Bool = false
    var proximity: CLProximity = CLProximity.Unknown
    
    init(name:String, alarmDistance: Int, uuid: NSUUID, major: Int, minor : Int)
    {
        self.name = name
        //self.distance = distance
        self.alarmDistance = alarmDistance
        super.init(uuid: uuid, major: major, minor: minor)
    }
    
    init(name:String, distance: Int, beacon: CLBeacon)
    {
        self.name = name
        self.distance = distance
        super.init(uuid: beacon.proximityUUID,  major: Int(beacon.major), minor: Int(beacon.minor))
    }
    
    required init(coder aDecoder: NSCoder) {
        self.name  = aDecoder.decodeObjectForKey("name") as! String
        self.distance  = aDecoder.decodeObjectForKey("distance") as! Int
        self.alarmDistance  = aDecoder.decodeObjectForKey("alarmDistance") as! Int
        super.init(coder: aDecoder)
//        var rawBeacon = aDecoder.decodeObjectForKey("beacon") as? NSData
//        
//         self.beacon =   NSKeyedUnarchiver.unarchiveObjectWithData(rawBeacon!) as! Tag
//             
//
          }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        let name = self.name
        aCoder.encodeObject(name, forKey: "name")
        
        let distance = self.distance
        aCoder.encodeObject(distance, forKey: "distance")
        
        let alarmDistance = self.alarmDistance
        aCoder.encodeObject(alarmDistance, forKey: "alarmDistance")

        
        super.encodeWithCoder(aCoder)
//         let tmpBeacon = NSKeyedArchiver.archivedDataWithRootObject(self.beacon!)
//            aCoder.encodeObject(tmpBeacon, forKey: "beacon")
    
    }
    
    
}
