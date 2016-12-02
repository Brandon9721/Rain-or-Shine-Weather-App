//
//  Location.swift
//  Rain or Shine
//
//  Created by Brandon Byrne on 2016-11-30.
//  Copyright © 2016 ZeahSoft. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
}
