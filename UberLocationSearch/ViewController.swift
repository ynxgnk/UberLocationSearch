//
//  ViewController.swift
//  UberLocationSearch
//
//  Created by Nazar Kopeika on 15.05.2023.
//

import UIKit
import MapKit /* 8 */

class ViewController: UIViewController {
    
    let mapView = MKMapView() /* 9 */

    override func viewDidLoad() {
        super.viewDidLoad() 
        view.addSubview(mapView) /* 10 */
        title = "Uber" /* 14 */
    }
    
    override func viewDidLayoutSubviews() { /* 11 */
        super.viewDidLayoutSubviews() /* 12 */
        mapView.frame = view.bounds /* 13 */
    }


}

