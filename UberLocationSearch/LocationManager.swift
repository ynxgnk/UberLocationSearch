//
//  LocationManager.swift
//  UberLocationSearch
//
//  Created by Nazar Kopeika on 15.05.2023.
//

import CoreLocation /* 1 */
import Foundation

struct Location { /* 5 */
    let title: String /* 6 */
    let coordinates: CLLocationCoordinate2D /* 6 */
}

class LocationManager: NSObject { /* 2 */
    
    static let shared = LocationManager() /* 3 */
    
    let manager = CLLocationManager() /* 4 */
    
    public func findLocations(with query: String, completion: @escaping (([Location]) -> Void)) { /* 7 */
        
    }
}
