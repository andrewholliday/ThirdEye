//
//  MappedBeacons.swift
//  Third Eye
//
//  Created by Admin on 10/10/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import Foundation



class MappedBeacons {
    
    
    func GetBeacon(code: String) -> Tag?
    {
        switch (code){
        
        case "ABC123":
            return Tag(uuid: NSUUID(UUIDBytes: "8492E75F-4FD6-469D-B132-043FE94921D8"), major: 1200, minor: 1000)
            break;
            
        case "ABC234":
            return Tag(uuid: NSUUID(UUIDBytes: "8492E75F-4FD6-469D-B132-043FE94921D8"), major: 1300, minor: 1000)
            break;
    
        case "ABC456":
            return Tag(uuid: NSUUID(UUIDBytes: "8492E75F-4FD6-469D-B132-043FE94921D8"), major: 1400, minor: 1000)
            break;
            
        default:
            return nil

        }
    }

}

