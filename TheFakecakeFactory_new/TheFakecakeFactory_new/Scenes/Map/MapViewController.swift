//
//  MapViewController.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 02/08/24.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    let bakeryCoordinate = CLLocationCoordinate2D(latitude: 19.4326018, longitude: -99.1332049)
    
    let mapView : MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cerrar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.customTabItemPink2.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .customTabItemPink2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let navigateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cómo llegar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.customTabItemPink2.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .customTabItemPink2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBgPink
        mapView.delegate = self
        setupUI()
        setupLocationManager()
    }
    
    private func setupUI() {
        view.addSubview(mapView)
        view.addSubview(closeButton)
        view.addSubview(navigateButton)
        
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        navigateButton.addTarget(self, action: #selector(directionsButtonTapped), for: .touchUpInside)
        
        let bakeryAnnotation = MKPointAnnotation()
        bakeryAnnotation.coordinate = bakeryCoordinate
        bakeryAnnotation.title = "The Fakecake Factory"
        mapView.addAnnotation(bakeryAnnotation)
        
        mapView.setRegion(MKCoordinateRegion(center: bakeryCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000), animated: true)
        
        setupConstraints()
        setupMap()
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 100),
            
            navigateButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            navigateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            navigateButton.heightAnchor.constraint(equalToConstant: 30),
            navigateButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    private func setupMap() {
        let destinationCoordinate = CLLocationCoordinate2D(latitude: 19.4326018, longitude: -99.1332049)
        let annotation = MKPointAnnotation()
        annotation.coordinate = destinationCoordinate
        annotation.title = "Destino"
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: destinationCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func directionsButtonTapped() {
        guard let userLocation = locationManager.location?.coordinate else { return }
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: bakeryCoordinate))
        request.transportType = .walking
        
        let directions = MKDirections(request: request)
        directions.calculate { [unowned self] response, error in
            guard let response = response else { return }
            
            for route in response.routes {
                self.mapView.addOverlay(route.polyline)
            }
        }
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = .customTabItemPink1
            renderer.lineWidth = 4
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        
        let point = MKPointAnnotation()
        point.title = "Mi ubicación"
        point.coordinate = userLocation.coordinate
        //mapView.removeAnnotation(mapView.annotations as! MKAnnotation)
        mapView.addAnnotation(point)
        
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
}
