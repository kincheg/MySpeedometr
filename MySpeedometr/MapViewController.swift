//
//  MapViewController.swift
//  MySpeedometr
//
//  Created by kin on 14.07.16.
//  Copyright © 2016 kin. All rights reserved.
//


import CoreLocation
import MapKit
class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var theMap: MKMapView!
    
    var manager:CLLocationManager!
    var myLocations: [CLLocation] = []
    var polyline: MKPolyline!
    var line = true
    var polylines = [MKPolyline]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup our Location Manager
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        //manager.stopUpdatingLocation()
        
        //Setup our Map View
        theMap.delegate = self
        theMap.mapType = MKMapType.standard // Standart Hybrid Satellite
        theMap.showsUserLocation = true
    }
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        myLocations.append(locations[0] )
        let spanX = 0.01
        let spanY = 0.01
        let newRegion = MKCoordinateRegion(center: theMap.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        theMap.setRegion(newRegion, animated: true)
        if (myLocations.count > 1){
            let sourceIndex = myLocations.count - 1
            let destinationIndex = myLocations.count - 2
            let c1 = myLocations[sourceIndex].coordinate
            let c2 = myLocations[destinationIndex].coordinate
            var a = [c1, c2]
            polyline = MKPolyline(coordinates: &a, count: a.count)
            polylines.append(polyline)
            
            if line {
                theMap.add(polyline)
            }else{
                theMap.removeOverlays(polylines)
            }
        }
    }
    
    
func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blue
            polylineRenderer.lineWidth = 5
            return polylineRenderer
        }
        return MKPolylineRenderer()
    }
    
    
    
    
    
}

