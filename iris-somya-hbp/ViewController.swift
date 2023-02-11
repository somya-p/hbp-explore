//
//  ViewController.swift
//  iris-somya-hbp
//
//  Created by Somya Prabhakar on 2/11/23.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    let mapView: MKMapView = {
       let map = MKMapView()
        return map
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setMapConstraints()
    }
    
    func setMapConstraints() {
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }


}



extension ViewController: MKMapViewDelegate {
    
}

