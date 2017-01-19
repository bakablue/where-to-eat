//
//  ViewRestoController.swift
//  WhereToEat
//
//  Created by Mélanie Godard on 15/12/2016.
//  Copyright © 2016 Wellcut. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation

class ViewRestoController: UIViewController {
    var resto : Resto?
    
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var navigation: UINavigationItem!
    @IBOutlet weak var labelStyle: UILabel!
    @IBOutlet weak var labelNote: UILabel!
    @IBOutlet weak var locationResto: MKMapView!
    @IBOutlet weak var map: MKMapView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard (resto != nil) else {
            return
        }
        navigation.title = resto!.name
        labelAddress.text = resto!.address
        labelStyle.text = resto!.style.rawValue
        labelNote.text = "No grade"
        if resto!.note != nil {
            labelNote.text = String(resto!.note!)
        }
        //locationResto.delegate = self
        //stylePicker.
        // Do any additional setup after loading the view, typically from a nib.
        let prefs = UserDefaults.standard
        prefs.set(resto?.name, forKey: Constants.UserDefaultsKeys.lastResto)
        
        //var address = "1 Infinite Loop, CA, USA"
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString(resto!.address) { (placemarks, error) in
            let placemark = placemarks![0]
            let mkplacemark = MKPlacemark(placemark: placemark)
            self.map.addAnnotation(mkplacemark)
            //let pointRect = MKMapRectMake(mkplacemark.x, mkplacemark.y, 0.1, 0.1);
            let annotationPoint = MKMapPointForCoordinate(mkplacemark.coordinate);
            let zoomRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1)
            
            self.map.setVisibleMapRect(zoomRect, animated: true)
            self.map.isZoomEnabled = true
            
        }
    }
}
