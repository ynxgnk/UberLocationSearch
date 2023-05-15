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
    let coordinates: CLLocationCoordinate2D? /* 6 */
}

class LocationManager: NSObject { /* 2 */
    
    static let shared = LocationManager() /* 3 */
    
//    let manager = CLLocationManager() /* 4 */
    
    public func findLocations(with query: String, completion: @escaping (([Location]) -> Void)) { /* 7 */
        let geoCoder = CLGeocoder() /* 73 */
        
        geoCoder.geocodeAddressString(query) { places , error in /* 74 */
            guard let places = places, error == nil else { /* 75 */
                completion([]) /* 77 */
                return /* 76 */
            }
            
            let models: [Location] = places.compactMap({ place in /* 78 */
                var name = "" /* 80 */
                if let locationName = place.name { /* 83 */
                    name += locationName /* 84 */
                }
                
                if let adminregion = place.administrativeArea { /* 85 */
                    name += ", \(adminregion)" /* 86 */
                }
                
                if let locality = place.locality { /* 87 */
                    name += ", \(locality)" /* 88 */
                }
                
                if let country = place.country { /* 89 */
                    name += ", \(country)" /* 90 */
                }
                
                print("\n\(place)\n\n") /* 91 */
                
                let result = Location(title: name,
                                      coordinates: place.location?.coordinate) /* 79 */
                return result /* 81 */
            })
            
            completion(models) /* 82 */
        }
    }
}
