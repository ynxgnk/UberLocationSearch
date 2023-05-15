//
//  ViewController.swift
//  UberLocationSearch
//
//  Created by Nazar Kopeika on 15.05.2023.
//

import UIKit
import MapKit /* 8 */
import FloatingPanel /* 15 */
import CoreLocation /* 104 */

class ViewController: UIViewController, SearchViewControllerDelegate { /* 103 add 1 protocol */
    
    let mapView = MKMapView() /* 9 */
    let panel = FloatingPanelController() /* 16 */

    override func viewDidLoad() {
        super.viewDidLoad() 
        view.addSubview(mapView) /* 10 */
        title = "Uber" /* 14 */
        
        let searchVC = SearchViewController() /* 101 */
        searchVC.delegate = self /* 102 */
        panel.set(contentViewController: searchVC) /* 17 */ /* 100 change SearchViewController */
        panel.addPanel(toParent: self) /* 18 */
    }
    
    
    override func viewDidLayoutSubviews() { /* 11 */
        super.viewDidLayoutSubviews() /* 12 */
        mapView.frame = view.bounds /* 13 */
    }
    
    func searchViewController(_ vc: SearchViewController, didSelectLocationWith coordinates: CLLocationCoordinate2D?) { /* 105 */
        
        guard let coordinates = coordinates else { /* 109 */
            return /* 110 */
        }
        
        panel.move(to: .tip, animated: true) /* 114 */
        
        mapView.removeAnnotations(mapView.annotations) /* 106 */

        let pin = MKPointAnnotation() /* 107 */
        pin.coordinate = coordinates /* 108 */
        mapView.addAnnotation(pin) /* 111 */
        
        mapView.setRegion(MKCoordinateRegion(
            center: coordinates,
            span: MKCoordinateSpan(
                latitudeDelta: 0.7,
                longitudeDelta: 0.7
            )
        ),
                          animated: true
        ) /* 112 */
    }
}

