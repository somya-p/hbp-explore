//
//  ViewController.swift
//  iris-somya-hbp
//
//  Created by Somya Prabhakar on 2/11/23.
//

import UIKit
import MapKit
import SwiftUI

class ViewController: UIViewController {
    
    var lines: [MKPolyline] = []
    
    var userName: String = ""
    
    var textField: UITextField = {
        let field = UITextField()
        field.textColor = .black
        field.backgroundColor = .white
        field.borderStyle = .line
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Enter name here"
        return field
    }()

    let mapView: MKMapView = {
       let map = MKMapView()
        return map
    }()
    
    let swiftUIController = UIHostingController(rootView: LandingView())

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let label = UILabel()
         label.text = "UIKit Screen"
         label.textColor = .black
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font = .boldSystemFont(ofSize: 21)
         view.addSubview(label)
        
        view.backgroundColor = .white
        
         let button = UIButton()
         button.setTitleColor(.blue, for: .normal)
         button.setTitle("View your movement", for: .normal)
         button.titleLabel?.textAlignment = .center
         button.translatesAutoresizingMaskIntoConstraints = false
         button.addTarget(self, action: #selector(onChange), for: .touchUpInside)
         button.titleLabel?.font = .boldSystemFont(ofSize: 21)
         view.addSubview(button)
        
        view.addSubview(textField)
         
         NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -32),
             button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
             button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 64)
         ])
        
        mapView.delegate = self
        
    }
    
    @objc func onChange() {
        setMapConstraints()
        mapView.setInitialLocation()
        getJSONData()
        drawRoutes()
    }
    
    func setMapConstraints() {
        view.addSubview(mapView)
        let text = UITextView()
        text.text = "userName"
        text.textColor = .red
        text.backgroundColor = .black
        view.addSubview(text)
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        text.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }

    
    func getJSONData() {
        
        if let path = Bundle.main.path(forResource: "Directions", ofType: "geojson") {
            print(path)
            do {
                guard let data =  try? String(contentsOfFile: path).data(using: .utf8) else {
                    return
                }
                print(data)
                let features = try MKGeoJSONDecoder().decode(data).compactMap { $0 as? MKGeoJSONFeature}
                parseJSON(features: features)
            } catch {
                print("oops")
            }
        } else {
            print("didnt work")
        }
    }
    
    func parseJSON(features: [MKGeoJSONFeature]) {
        for feature in features {
            guard let geo = feature.geometry.first, let properties = feature.properties else { return }
            
            if let polyline = geo as? MKPolyline {
                lines.append(polyline)
            }
        }
    }
    
    func drawRoutes() {
        for line in lines {
            DispatchQueue.main.async {
                self.mapView.addOverlay(line)
    //            let lines2: [MKOverlay] = self.lines as [MKOverlay]
    //            self.mapView.addOverlays(lines2)
                
                self.mapView.setVisibleMapRect(line.boundingMapRect, animated: true)
            }
        }
    }

}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKGradientPolylineRenderer(overlay: overlay)

        renderer.strokeColor = .systemBlue
        renderer.lineCap = .round
        renderer.lineWidth = 1
        
        return renderer
    }
}

private extension MKMapView {
    func setInitialLocation() {
        let coordinateRegion = MKCoordinateRegion(
            center: CLLocation(latitude: 76.75568103790283, longitude: 30.764148466172053).coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        setRegion(coordinateRegion, animated: true)
    }
}
