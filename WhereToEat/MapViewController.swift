//
//  MapViewController.swift
//  WhereToEat
//
//  Created by Mélanie Godard on 13/01/2017.
//  Copyright © 2017 Wellcut. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    let locationManager = CLLocationManager()
    var address : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters

        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        }
    }
    
    @IBAction func addRestaurantFromCurrentLocation(_ sender: Any) {
       /*do {
            self.navigationController?.pushViewController(ViewController(), animated: <#T##Bool#>)(animated: true)
        }*/
    }
    func displayUserLocation(userLocation : CLLocation?) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation!, completionHandler: { (placemarks, error) in
            
            let placemark = placemarks![0]
            let mkplacemark = MKPlacemark(placemark: placemark)
            self.map.addAnnotation(mkplacemark)
            //let pointRect = MKMapRectMake(mkplacemark.x, mkplacemark.y, 0.1, 0.1);
            let annotationPoint = MKMapPointForCoordinate(mkplacemark.coordinate);
            let zoomRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1)
            
            self.map.setVisibleMapRect(zoomRect, animated: true)
            self.map.isZoomEnabled = true
            
            self.address = "\(mkplacemark.thoroughfare!)\n\(mkplacemark.postalCode!) \(mkplacemark.locality!)\n\(mkplacemark.country!)"
        })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        displayUserLocation(userLocation: manager.location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
        print(error.localizedDescription)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addRestoFromLocation") {
            guard let destination = segue.destination as? ViewController else {
                return
            }

            destination.addressFromLocation = address
        }
    }
}
