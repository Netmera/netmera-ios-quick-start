//
//  MapViewController.swift
//  iNeo
//
//  Created by inomera on 16.06.2020.
//  Copyright © 2020 Netmera. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

  @IBOutlet private var mapView: MKMapView!
  let locationManager = CLLocationManager()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    mapView.delegate = self

    
    self.fetchRegionsOnMap()
  }
  
  func fetchRegionsOnMap() {
    let regions = locationManager.monitoredRegions
    let circularRegions = regions.map { (item) -> CLCircularRegion in
      return item as! CLCircularRegion
    }
    print(circularRegions)
    mapView.addAnnotations(circularRegions)
    let overlays = circularRegions.map { MKCircle(center: $0.center, radius: $0.radius) }
    mapView?.addOverlays(overlays)
    
//    for region in regions {
//      print(region)
//      if let circularRegion = region as? CLCircularRegion {
//        let circle = MKCircle(center: circularRegion.center, radius: circularRegion.radius)
//        mapView.addOverlays(overlays)
////        let annotations = MKPointAnnotation()
////        annotations.title = region.identifier
////        annotations.coordinate = CLLocationCoordinate2D(latitude:
////          circularRegion.center.latitude, longitude: circularRegion.center.latitude)
////        mapView.addAnnotation(annotations)
//      }
//    }
  }

}

extension MapViewController: MKMapViewDelegate {
  // 1
//  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//    guard annotation is CLCircularRegion else { return nil }
//
//    let identifier = "Annotation"
//    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//
//    if annotationView == nil {
//        annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//        annotationView!.canShowCallout = true
//
//      let btn = UIButton(type: .detailDisclosure)
//      annotationView?.rightCalloutAccessoryView = btn
//
//    } else {
//        annotationView!.annotation = annotation
//    }
//
//    return annotationView
//
////    if annotation is MKUserLocation {
////      return nil
////    }
////
////    else {
////      let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
////      annotationView.image = UIImage(named: "location")
////      return annotationView
////    }
//  }
  
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    guard let region = view.annotation as? CLCircularRegion else { return }
    let placeName = region.identifier
    let placeInfo = "latitude: \(region.center.latitude)\nlongitude: \(region.center.longitude)\nradius:\(region.radius)"
    
    let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    guard let region = view.annotation as? CLCircularRegion else { return }
    let placeName = region.identifier
    let placeInfo = "latitude: \(region.center.latitude)\nlongitude: \(region.center.longitude)\nradius:\(region.radius)"
    
    let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }

  
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      let renderer = MKCircleRenderer(overlay: overlay)
      renderer.fillColor = UIColor.black.withAlphaComponent(0.5)
      renderer.strokeColor = UIColor.blue
      renderer.lineWidth = 1
      return renderer
  }
  
//  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//    // 2
//    guard let annotation = annotation as? Artwork else {
//      return nil
//    }
//    // 3
//    let identifier = "artwork"
//    var view: MKMarkerAnnotationView
//    // 4
//    if let dequeuedView = mapView.dequeueReusableAnnotationView(
//      withIdentifier: identifier) as? MKMarkerAnnotationView {
//      dequeuedView.annotation = annotation
//      view = dequeuedView
//    } else {
//      // 5
//      view = MKMarkerAnnotationView(
//        annotation: annotation,
//        reuseIdentifier: identifier)
//      view.canShowCallout = true
//      view.calloutOffset = CGPoint(x: -5, y: 5)
//      view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//    }
//    return view
//  }
}

extension CLCircularRegion: MKAnnotation {
  public var coordinate: CLLocationCoordinate2D {
    return self.center
  }
  
  public var title: String? {
    return self.identifier
  }
}
