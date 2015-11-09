//
//  Beacon.swift
//  Third Eye
//
//  Created by Admin on 10/10/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import Foundation
import CoreLocation

class Tag: NSObject, NSCoding{
    
    var uuid: NSUUID
    var major: Int
    var minor: Int
    
//    override init()
//    {}
    
    init(beacon: CLBeacon)
    {
        self.uuid = beacon.proximityUUID
        self.major = Int(beacon.major)
        self.minor = Int(beacon.minor)
    }
    
    init(uuid: NSUUID, major: Int, minor : Int)
    {
        self.uuid = uuid
        self.major = major
        self.minor = minor
    }
    
    
    required init(coder aDecoder: NSCoder) {
        
        let uuidString = aDecoder.decodeObjectForKey("uuid") as! String

        self.uuid  = NSUUID(UUIDString: uuidString)!
        self.major  = aDecoder.decodeObjectForKey("major") as! Int
        self.minor  = aDecoder.decodeObjectForKey("minor") as! Int
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        let uuid = self.uuid.UUIDString
    
        aCoder.encodeObject(uuid, forKey: "uuid")
        let major = self.major
        aCoder.encodeObject(major, forKey: "major")
        let minor = self.minor
        aCoder.encodeObject(minor, forKey: "minor")

        
    }
}